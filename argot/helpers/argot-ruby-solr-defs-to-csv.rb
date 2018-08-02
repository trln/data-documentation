require 'csv'
require 'open-uri'
require 'yaml'

fields_file = open('https://raw.githubusercontent.com/trln/argot-ruby/master/lib/data/solr_fields_config.yml'){|f| f.read}
fields_config = YAML::load(fields_file)

SolrField = Struct.new(:fieldname, :type, :stored, :single, :sort, :suffixed)

solr_fields = []
INT_TYPES = %w[i float long double].freeze

fields_config.each do |f|
  #default type is t according to https://github.com/trln/argot-ruby/blob/eddde57a13f21ae2101b9538e73ce0fc494b178d/lib/argot/suffixer.rb#L43

  sf = SolrField.new(f[0], 't', '', '', '', f[0])
  fhash = f[1]
  sf.type = fhash['type'] if fhash['type']
  if fhash.has_key?('attr')
    if fhash['attr'].include?('sort')
      sf.sort = 'sort'
      sort_suffix = INT_TYPES.include?(sf.type) ? '_isort' : '_ssort'
      sf.suffixed = sf.suffixed + sort_suffix
    else
      sf.suffixed = sf.suffixed + '_' + sf.type
    end
    
    if fhash['attr'].include?('stored')
      sf.stored = 'stored'
      sf.suffixed = sf.suffixed + '_stored'
    end
    
    if fhash['attr'].include?('single')
      sf.single = 'single'
      sf.suffixed = sf.suffixed + '_single'
    end
    
  else
    sf.suffixed = sf.suffixed + '_' + sf.type
  end
  solr_fields << sf
end


CSV.open('solr_field_config.csv', 'wb') do |csv|
  csv << ['fieldname', 'type', 'stored', 'arity', 'sort', 'fieldname with suffix']
  solr_fields.each do |f|
    csv << [f.fieldname, f.type, f.stored, f.single, f.sort, f.suffixed]
  end
end

