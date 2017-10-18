require 'csv'
require 'json'
require 'net/http'
require 'uri'
require 'pp'
require 'zip'
require 'open-uri'
require 'rdf'
require 'rdf/ntriples'
require 'sparql'
require 'linkeddata'

relator_data_uri = 'http://id.loc.gov/static/data/vocabularyrelators.nt.zip'
relator_data = 'relators.n3'

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# get RDF relator data from LC and unzip it
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
data_status = ARGV[0]

if data_status == 'refresh'
  File.delete(relator_data) if File.exist?(relator_data)
  
  content = open(relator_data_uri)

  Zip::File.open_buffer(content) do |zip|
    zip.each do |entry|
      entry.extract(relator_data)
    end
  end
else
  puts "Using existing relator data."
end

class Relator
  attr_accessor :code
  attr_accessor :current
  attr_accessor :category
  attr_accessor :label
  attr_reader :uri
  attr_reader :graph

  def initialize(uri, label, graph)
    @uri = uri
    @code = uri[-3,3]
    @label = label
    @graph = graph
  end

  def categorize_by_parent(cat_hash)
    parent = JSON.parse(SPARQL.execute("
                           PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                           SELECT * WHERE 
                           { <#{self.uri}> rdfs:subPropertyOf ?parent .
                             FILTER(REGEX(STR(?parent), '^http://id.loc.gov/vocabulary/relators/...$'))
                           } 
                          ", graph).to_json)
    if parent['results']['bindings'].size > 0
      parenturi = parent['results']['bindings'][0]['parent']['value']
    end

    if parenturi
      @category = cat_hash[@parenturi]
    end
  end

  def mark_the_uncategorized
    @category = 'uncategorized' unless @category
  end
    
end

class DeprecatedRelator < Relator
  attr_accessor :new_code
  attr_accessor :new_uri

  def initialize(uri, label, graph, new_uri)
    super(uri, label, graph)
    @current = false
    @new_uri = new_uri
    @new_code = new_uri[-3,3]
  end

  def categorize(cat_hash)
    @category = cat_hash[@new_uri]
  end
end

class ActiveRelator < Relator
  def initialize(uri, label, graph)
    super(uri, label, graph)
    @current = true
  end

  def categorize(cat_hash)
    @category = cat_hash[@uri]
  end
end

graph = RDF::Repository.load(relator_data)

#hash of relator objects, with key = uri 
relators = {}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# get all active and deprecated relators
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
deprecated = JSON.parse(SPARQL.execute("
                           PREFIX relcode: <http://id.loc.gov/vocabulary/relators/>
                           PREFIX mads: <http://www.loc.gov/mads/rdf/v1#>
                           PREFIX rdfns: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
                           SELECT * WHERE 
                           { ?uri rdfns:type mads:DeprecatedAuthority .
                             ?uri mads:useInstead ?newuri .
                             OPTIONAL { ?uri mads:deprecatedLabel ?deplabel . 
                                        FILTER (LANG(?deplabel) = 'en') . }
                           } 
                          ", graph).to_json)

active = JSON.parse(SPARQL.execute("
                           PREFIX relcode: <http://id.loc.gov/vocabulary/relators/>
                           PREFIX mads: <http://www.loc.gov/mads/rdf/v1#>
                           PREFIX rdfns: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
                           SELECT * WHERE 
                           { ?uri rdfns:type mads:Authority .
                             ?uri mads:authoritativeLabel ?label .
                             ?uri mads:isMemberOfMADSScheme ?colls
                             FILTER (LANG(?label) = 'en') . 
                           }
                          ", graph).to_json)

deprecated['results']['bindings'].each { |result|
  this_relator = DeprecatedRelator.new(
    result['uri']['value'],
    result['deplabel']['value'].downcase,
    graph,
    result['newuri']['value']
  )
  relators[this_relator.uri] = this_relator
}

active['results']['bindings'].each { |result|
  this_relator = ActiveRelator.new(
    result['uri']['value'],
    result['label']['value'].downcase,
    graph
  )
  relators[this_relator.uri] = this_relator
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# populate hash of relator_uri => category
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
cat_hash = {}

categories = {
  'http://purl.org/dc/elements/1.1/contributor' => {'predicate' => 'rdfs:subPropertyOf', 'category' => 'contributor'},
  'http://purl.org/dc/elements/1.1/publisher' => {'predicate' => 'rdfs:subPropertyOf', 'category' => 'publisher'},
  'http://id.loc.gov/vocabulary/relators/collection_RDAContributor' => {'predicate' => 'mads:isMemberOfMADSCollection', 'category' => 'contributor'},
  'http://id.loc.gov/vocabulary/relators/collection_RDACreator' => {'predicate' => 'mads:isMemberOfMADSCollection', 'category' => 'creator'},
  'http://id.loc.gov/vocabulary/relators/collection_RDAManufacturer' => {'predicate' => 'mads:isMemberOfMADSCollection', 'category' => 'manufacturer'},
  'http://id.loc.gov/vocabulary/relators/collection_RDAPublisher' => {'predicate' => 'mads:isMemberOfMADSCollection', 'category' => 'publisher'},
  'http://id.loc.gov/vocabulary/relators/collection_RDADistributor' => {'predicate' => 'mads:isMemberOfMADSCollection', 'category' => 'distributor'},
  'http://id.loc.gov/vocabulary/relators/collection_RDAOwner' => {'predicate' => 'mads:isMemberOfMADSCollection', 'category' => 'owner'},
  'http://id.loc.gov/vocabulary/relators/collection_RDAOther' => {'predicate' => 'mads:isMemberOfMADSCollection', 'category' => 'other'}
}


categories.each_pair { |caturi, cat|
  catlist = JSON.parse(SPARQL.execute("
                           PREFIX mads: <http://www.loc.gov/mads/rdf/v1#>
                           PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
                           SELECT ?uri WHERE 
                           { ?uri #{cat['predicate']} <#{caturi}> .
                           }
                          ", graph).to_json)

  catlist['results']['bindings'].each { |result|
    cat_hash["#{result['uri']['value']}"] = cat['category']
  }
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# categorize relators
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
relators.values.each { |rel|
  rel.categorize(cat_hash)
  rel.categorize_by_parent(cat_hash) unless rel.category
  rel.mark_the_uncategorized
}

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# create category lookup hash
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
lookup = {}

relators.values.each { |rel|
  lookup[rel.code] = rel.category
  lookup[rel.label] = rel.category
}

File.open("../maps/_relator_categories.json", "w") do |f|
  f.write(lookup.to_json)
end

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# create code to label lookup
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
expansions = {}
relators.values.each { |rel| expansions[rel.code] = rel.label }

File.open("../maps/_relator_code_to_label.json", "w") do |f|
  f.write(expansions.to_json)
end

# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# create human-friendly list of relators by category
# -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
catlist = {}
relators.values.each { |rel|
  if catlist[rel.category]
    catlist[rel.category] << rel.code
    catlist[rel.category] << rel.label
  else
    catlist[rel.category] = [rel.code]
    catlist[rel.category] << rel.label
  end
}

CSV.open("_relator_categories.csv", "wb") do |csv|
  csv << ['category', 'relator']
  catlist.each_pair { |cat, vals|
    vals.each { |val| csv << [cat, val] }
  }
end
