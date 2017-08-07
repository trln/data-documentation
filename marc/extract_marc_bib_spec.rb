require 'net/http'

htmlsrc = Net::HTTP.get_response(URI('http://www.loc.gov/marc/bibliographic/ecbdlist.html'))
if htmlsrc.message == 'OK'
  data = htmlsrc.body
  data = data.gsub!(/^.*<pre>/m, '')
  data = data.gsub!(/<\/pre>.*/m, '')
  data = data.gsub!(/^--Leader.*?\n--/m, '--')
end

#p data

 data_chunks = data.split(/^\s*$/)
 marcfields = ["MARC tag\tField name\tRepeatability\tOther note"]
 marcsfs = ["MARC tag\tField name\tField repeatability\tField note\tSubfield delimiter\tSubfield name\tSubfield repeatability\tSubfield note"]

data_chunks_in_lines = []

data_chunks.each do |f|
  lines = f.split(/\n/).each { |ln| ln.chomp! }
  data_chunks_in_lines << lines.select { |ln| ln !~ /^( *|   Subfield Codes.*|--.*)$/ }  
end

field_data_in_lines = data_chunks_in_lines.select { |arr| arr.size > 0 }

# A start at improving this code, used for some debugging. Once problem was fixed, didn't have time to refactor the whole thing. Whee. --2017-08-07
# class Field
#   attr_reader = :tag
#   attr_reader = :name
#   attr_reader = :repeat
#   attr_reader = :context
#   attr_reader = :subfields

#   def initialize(flines)
#     fdata = /(^\d{3}) - ([^(\[]+)/.match(flines.shift)
#     @tag = fdata[1]
#     @name = fdata[2]
#     @repeat = ''
#     @context = ''
#     @subfields = []

#     puts "#{@tag} -- #{@name}"
#   end
# end

# #field_data_in_lines.each { |fd| Field.new(fd) }

# class Subfield
#   attr_reader = :tag
#   attr_reader = :name
#   attr_reader = :repeat
#   attr_reader = :context
# end



 data_chunks.each do |f|
  lines = f.split(/\n/)
  lines.each { |ln| ln.chomp! }
  keeplines = []
  lines.each do |ln|
    if ln.match(/^$/)
      next
    elsif ln.match(/^   Subfield Codes/)
      next
    else
      keeplines << ln
    end
  end

  if keeplines.size == 0
    next
  else
    fielddata = ''
    inddata = []
    sfdata = []
    keeplines.each do |ln|
      if ln.match(/^\d{3}/)
        fielddata = ln
      elsif ln.match(/^      \$/)
        sfdata << ln
      end
    end
  end

  ftag = fielddata[0, 3]
  fname = / - (.*?) \(/.match(fielddata)[1]
  frep = ''
  fcontext = ''
  if /\((N?R)\)/.match(fielddata)
    frep = /\((N?R)\)/.match(fielddata)[1]
  end
  frep = '.' if frep == ''
  if /(\[.+\])/.match(fielddata)
    fcontext = /(\[.+\])/.match(fielddata)[1]
  end
  fcontext = '.' if fcontext == ''
  marcfields << "#{ftag}\t#{fname}\t#{frep}\t#{fcontext}"

  sfdata.each { |ln|
    sfdelim = ''
    sfname = ''
    sfrep = ''
    sfmore = ''
    
    sfdelim = /\$(.|.-.) (-|S)/.match(ln)[1]
    if /\$. - .* \(/.match(ln)
      sfname = /\$. - (.*) \(/.match(ln)[1]
    elsif /\$.-. S/.match(ln)
      sfmame = /\$.-. (S.*)/.match(ln)[1]
    else
      sfname = ''
    end
    if /\(N?R\)/.match(ln)
      sfrep = /\((N?R)\)/.match(ln)[1]
    else
      sfrep = '.'
    end
    if /\[.+\]/.match(ln)
      sfmore = /(\[.+\])/.match(ln)[1]
    else
      sfmore = '.'
    end

    marcsfs << "#{ftag}\t#{fname}\t#{frep}\t#{fcontext}\t#{sfdelim}\t#{sfname}\t#{sfrep}\t#{sfmore}"
  }
end

open('_marc_bib_tags.tsv', 'w') { |f|
  marcfields.each { |mf|
    f.puts mf
  }
}

open('_marc_bib_subfields.tsv', 'w') { |f|
  marcsfs.each { |mf|
    f.puts mf
  }
}

