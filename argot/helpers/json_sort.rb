require 'json'

file = File.read('mockup-doc.json')

data = JSON.parse(file)

#puts data.inspect

sorted = Hash[ data.sort_by { |k, v| k } ]

#puts sorted.inspect

puts JSON.generate(sorted)
