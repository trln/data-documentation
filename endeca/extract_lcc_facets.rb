#!/usr/bin/env ruby
#
require 'nokogiri'
require 'ostruct'
require 'json'

# future expansion; use as basis for checking whether 
# call number falls into range
# https://github.com/pulibrary/lcsort
# require 'lcsort'

# extracts LC Call number ranges used for faceting into Endeca as
# JSON.  
# usage: ./extract_lcc_facets.rb path_to_LCC_NLM_full.xml
# Original found in TRLN_pipeline SVN repo at TRLN.
#
# TODO: XML output (more hierarchical?)
# TODO: flesh out 'contains' method

doc = File.open(ARGV[0] || 'LCC_NLM_full.xml') do |f|
  Nokogiri::XML(f)
end

class LCCRange < Struct.new(:label, :bounds, :children)
  def initialize(name, bounds = [], children = [])
    super
  end

  def <<(child)
    children << child
  end

  def contains(normalized_lccn)
    if bounds.empty?
      false
    else
      check = normalized_lccn.split[0]
      bounds[0] <= check && bounds[1] >= check
    end
  end

  def to_json(*_)
    JSON.generate(to_h)
  end
end

def extract_range(el, indent = 0)
  label = el.xpath('DVAL/SYN')[0].text
  children = el.xpath('DIMENSION_NODE').collect {|x| extract_range(x, indent + 1) }
  bounds = [ el.xpath('DVAL/LBOUND/BOUND/@VALUE').first, el.xpath('DVAL/UBOUND/BOUND/@VALUE').first ]
  bounds = [] if bounds.all? &:nil?
  range = LCCRange.new(label, bounds, children)
  range
end

results = doc.xpath('/DIMENSIONS/DIMENSION/DIMENSION_NODE/DIMENSION_NODE').collect do |node|
  extract_range(node)
end

puts results.to_json
