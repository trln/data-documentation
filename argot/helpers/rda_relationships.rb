require "json"
require "net/http"
require "uri"
require "pp"

datauri = URI.parse("http://rdaregistry.info/Elements/u.json-ld")


#return hash of unconstrained RDA properties
def grab_json(uri)
  http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri)

  response = http.request(request)

  if response.code == "200"
    return JSON.parse(response.body)["@graph"]
  else
    return "Error getting JSON: #{response.code}"
  end
end

rdaprop = grab_json(datauri)

id_to_label = {}
topprops = []
parents = []

rdaprop.each { |prop|
  # populate id_to_label
  id = prop["@id"]
  eng_label = prop["label"]["en"]
  id_to_label[id] = eng_label

  topprops << id unless prop.has_key?("subPropertyOf")

  parents << id if prop.has_key?("hasSubproperty")
}

#topprops.each { |prop| puts id_to_label[prop] }

parents.each { |p| puts id_to_label[p] }
