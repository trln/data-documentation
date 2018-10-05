require 'net/http'
require 'json'

htmlsrc = Net::HTTP.get_response(URI('http://www.loc.gov/marc/bibliographic/ecbdlist.html'))
if htmlsrc.message == 'OK'
  data = htmlsrc.body
  data = data.gsub!(/^.*<pre>/m, '')
  data = data.gsub!(/<\/pre>.*/m, '')
  data = data.gsub!(/^--Leader.*?\n--/m, '--')
end

class FieldDef
  attr_reader :tag_def
  attr_reader :sf_defs
  attr_reader :tag

  def initialize(field_def)
    lines = field_def.split(/\n/).each { |ln| ln.chomp! }
    @sf_defs = []
    lines.each do |line|
      if line =~ /^[0-9]{3} - /
        @tag_def = line
        @tag = line.byteslice(0,3)
      elsif line =~ /^ +\$. - /
        @sf_defs << line
      end
    end
  end
end

class Field
  attr_reader :tag
  attr_reader :name
  attr_reader :repeat
  attr_reader :context
  attr_accessor :subfields

  def initialize(fdata)
    fdata = /(^\d{3}) - ([^(\[]+.*)(\(.*\))(.*)$/.match(fdata)
    @tag = fdata[1]
    @name = fdata[2]
    @repeat = fdata[3].delete("()") if fdata[3] =~ /^\(N?R\)$/
    @context = fdata[4].delete("[] -")
    @subfields = {}
  end

  def to_h
    { @tag => {
        "name" => @name,
        "repeat" => @repeat,
        "context" => @context,
        "subfields" => @subfields
      }
    }
  end
end

class Subfield
  attr_reader :code
  attr_reader :name
  attr_reader :repeat
  attr_reader :context

  def initialize(sf_def)
    sfdata = /^ +\$(.) - ([^(\[]+).*/.match(sf_def)
    @code = sfdata[1]
    @name = sfdata[2].strip
    if sf_def =~ /\(N?R\)/
      rpt = /\((N?R)\)/.match(sf_def)
      @repeat = rpt[1]
    else
      @repeat = ""
    end
    if sf_def =~ /\[.+\] *$/
      cxt = /\[(.*)\] *$/.match(sf_def)
      @context = cxt[1].delete("[] -")
    else
      @context = ''
    end
  end
end

field_defs = data.split(/^\s*$/)
defs = field_defs.map { |fd| FieldDef.new(fd) }

fieldhash = {}
fields = defs.map { |d| Field.new(d.tag_def).to_h }.each do |f|
  f.each { |k, v| fieldhash[k] = v }
end

defs.each do |d|
  d.sf_defs.each do |sfd|
    sf = Subfield.new(sfd)
    sfh = {
      "name" => sf.name,
      "repeat" => sf.repeat,
      "context" => sf.context
    }
    fieldhash[d.tag]['subfields'][sf.code] = sfh
  end
end

open('marc_definition.json', 'w'){ |f| f.puts JSON.pretty_generate(fieldhash)}
