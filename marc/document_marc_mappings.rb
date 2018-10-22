require 'pp'
require 'simple_xlsx_reader'
doc = SimpleXlsxReader.open('../argot/argot.xlsx')
mappings_d = doc.sheets[1].data
mappings_h = doc.sheets[1].headers
fields_d = doc.sheets[0].data
fields_h = doc.sheets[0].headers

# Then, I throw out mappings that are not from standard MARC source data and take a look at the data.
marc_only = mappings_d.select{ |r| r[2] == "MARC"}

# Throw out columns we don't need
less_data = marc_only.map { |m| [m[0], m[1], m[3], m[4], m[5], m[6], m[7], m[8], m[9], m[10]]}


fixes = less_data.each do |m|
  m[4] = m[4] = '0' if m[4] == 'LDR' # Change LDR to 0 in MARC tag element
  m[4] = m[4].to_i # Change MARC tags to integers for sort
  m[3] = m[3].sub('GEN', 'ALL INSTITUTIONS')  # Change GEN to ALL in institution element
  m[6] = ' ' if m[6] == 'none' # Change none to ' ' in constraint
end

=begin
Now we create a more complex data structure out of our mappings, so that we can report out on them in a structured way. The hash we create below will look like:

{MARC TAG => 
  {INSTITUTION => 
    {CONSTRAINT => 
      {ARGOT FIELD => 
        {ARGOT ELEMENT => { :subfields => x,
                          :processing_type => x,
                          :processing instructions => x,
                          :notes => x,
                          :provisional => x }
        }
      }
    }
  }

First we set up the MARC TAGs for population...
=end
map_hash = {}
fixes.each do |m|
  map_hash[m[4]] = {} unless map_hash.has_key?(m[4])
end


# Then we set up the INSTITUTION level structure for population...
fixes.each do |m|
  map_hash[m[4]][m[3]] = {} unless map_hash[m[4]].has_key?(m[3])
end

# Then we set up the CONSTRAINT level structure for population...
fixes.each do |m|
  map_hash[m[4]][m[3]][m[6]] = {} unless map_hash[m[4]][m[3]].has_key?(m[6])
end

# Then we set up the ARGOT FIELD level for population
fixes.each do |m|
  map_hash[m[4]][m[3]][m[6]][m[0]] = {} unless map_hash[m[4]][m[3]][m[6]].has_key?(m[0])
end

# Then we set up the ARGOT ELEMENT level structure for population...
fixes.each do |m|
  map_hash[m[4]][m[3]][m[6]][m[0]][m[1]] = [] unless map_hash[m[4]][m[3]][m[6]][m[0]].has_key?(m[1])
end

# Then we populate the mappings hash with the details...
fixes.each do |m|
  this_mapping = { :subfields => m[5],
                   :processing_type => m[7],
                   :processing_inst => m[8],
                   :notes => m[9],
                   :provisional => m[2]}
  map_hash[m[4]][m[3]][m[6]][m[0]][m[1]] << this_mapping
end

# Then we build a hash out of the Argot field data we want to merge into mappings statements...
field_hash = {}
fields_d.each do |f|
  field_hash[f[0]] = {:indexes => f[11],
                      :facet => f[13],
                      :disp_b => f[14],
                      :disp_f => f[15],
                      :disp_note => f[16],
                      :doc => f[23]}  
end

# From these two hashes, we generate a human-readable report in HTML. Here, we create the HTML file and all the parts of it that come before the dump of data.

hfile = File.new("marc_mappings.html", "w")
hfile.puts('<HTML>')
hfile.puts('<HEAD>')
hfile.puts('<title>Mappings from MARC to Argot</title>')
hfile.puts("<style media='all' type='text/css'>")
hfile.puts("body {font-family: Helvetica Neue, sans-serif;}")
hfile.puts("h2 {text-indent: 1em;}")
hfile.puts("h3 {text-indent: 2em;}")
hfile.puts("h4 {text-indent: 3em;}")
hfile.puts(".mapping {border: 1px dotted gray; margin-left: 4em; margin-bottom: 1em; padding: 0.5em;}")
hfile.puts(".provisional {font-variant: small-caps; color: red; justify-content: center;}")
hfile.puts("</style>")
hfile.puts('</HEAD>')
hfile.puts('<BODY>')
hfile.puts('<h1>Mappings from MARC to Argot</h1>')

nav = []
map_hash.keys.sort.each do |tag|
  tag_s = tag.to_s.rjust(3, '0') unless tag == 0
  tag_s = 'LDR' if tag == 0
  nav << "<a href=\"#{tag_s}\">#{tag_s}</a>"
end

hfile.puts(nav.join(' | '))

map_hash.sort.each do |tag, insthash|
  tag_s = tag.to_s.rjust(3, '0') unless tag == 0
  tag_s = 'LDR' if tag == 0
  hfile.puts("<h2 id=\"#{tag_s}\">#{tag_s}</h2>")
  insthash.sort.each do |inst, constrainthash|
    hfile.puts("<h3>Mappings for #{inst}</h3>")
    constrainthash.sort.each do |constraint, afieldhash|
      if constraint == ' '
        hfile.puts('<h4>IN ALL CASES...</h4>')
      else
        hfile.puts("<h4>WHEN #{constraint} THEN...</h4>")
      end
      afieldhash.sort.each do |afield, aelementhash|
        doc = field_hash[afield][:doc]
        doclink = doc if doc.start_with?('http')
        docneeded = 'y' if doc.start_with?('needed')
        
        
        aelementhash.sort.each do |aelement, mappings|
          search_in = field_hash[aelement][:indexes] unless field_hash[aelement][:indexes] == 'not indexed'
          facet = field_hash[aelement][:facet] unless field_hash[aelement][:facet] == 'x'
          disp_b = "Displayed in brief record: #{field_hash[aelement][:disp_b]}" unless field_hash[aelement][:disp_b] == 'x'
          disp_f = "Displayed in full record: #{field_hash[aelement][:disp_f]}" unless field_hash[aelement][:disp_f] == 'x'
          disp_n = "Notes on display: #{field_hash[aelement][:disp_note]}" unless field_hash[aelement][:disp_note] == 'x'
          mappings.each do |m|
            hfile.puts('<div class="mapping">')
            if m[:provisional] == 'y'
              hfile.puts('<div class="provisional">Provisional mapping</div>')
            end
            if m[:processing_type] == 'constant'
              hfile.puts("<b>Constant value: #{aelement} #{m[:processing_inst]}</b>")
            elsif m[:processing_type] == 'DO NOT SET'
              hfile.puts("<b>Do not set #{aelement} value</b>")
            else
              hfile.puts("<b>#{m[:subfields]} => #{aelement}</b>")
            end
            
            case m[:processing_type]
            when 'array_from_subelements'
              xform_type = 'Contents of each subfield becomes separate element in array. <i>Example: $a cat $b dog $c fish => ["cat", "dog", "fish"]</i>'
            when 'concat_subelements'
              xform_type = 'Contents of subfields joined together into one string, separated by space. <i>Example: $a cat $b dog $c fish => "cat dog fish"</i>'
            when 'map subelement to value'
              xform_type = 'Subfield value is a code, which is translated into a human readable value and becomes element in array. <i>Example: $a eng $b ger=> ["English", "German"]</i>'
            when 'map indicator value'
              xform_type = 'Indicator value is translated into human readable value. <i>Example: 246 i2=4 => "Cover title"</i>'
            end
            
            unless m[:processing_type] == 'constant'
              hfile.puts("<br />Processing method: #{xform_type}") if xform_type
              hfile.puts("<br />Special mapping instructions: #{m[:processing_inst]}") unless m[:processing_inst] =~ /^(See linked|x)/
            end
            
            hfile.puts("<br />&nbsp;<br />")
            
            if search_in
              hfile.puts("Searchable as: #{search_in.split(';;;').join(', ')}") unless search_in.start_with?('facet')
            else
              hfile.puts("Not searchable")
            end
            hfile.puts("<br />Populates facet: #{facet}") if facet
            hfile.puts("<br />#{disp_b}") if disp_b
            hfile.puts("<br />#{disp_f}") if disp_f
            hfile.puts("<br />#{disp_n}") if disp_n
            
            hfile.puts("<br />&nbsp;<br />")
            
            if doclink
              hfile.puts("For details, see <a href=\"#{doclink}\">documentation on Argot field: #{afield}</a>")
            elsif docneeded == 'y'
              hfile.puts("More details forthcoming in documentation to be written for Argot field: #{afield}")
            end
            
            hfile.puts('</div>')
          end
        end
      end
    end
  end
end

hfile.puts('</BODY>')
hfile.puts('</HTML>')
hfile.close
