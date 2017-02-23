require 'net/http'

htmlsrc = Net::HTTP.get_response(URI('http://www.loc.gov/marc/bibliographic/ecbdlist.html'))
if htmlsrc.message == 'OK'
  data = htmlsrc.body
  data = data.gsub!(/^.*<pre>/m, '')
  data = data.gsub!(/<\/pre>.*/m, '')
  data = data.gsub!(/^--Leader.*?\n--/m, '--')
end

fields = data.split(/^$/)
marcfields = ["MARC tag\tField name\tRepeatability\tOther note"]
marcsfs = ["MARC tag\tField name\tField repeatability\tField note\tSubfield delimiter\tSubfield name\tSubfield repeatability\tSubfield note"]

fields.each do |f|
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
  if /(\[.+\])/.match(fielddata)
    fcontext = /(\[.+\])/.match(fielddata)[1]
  end
  fcontext = '.' if fcontext == ''
  marcfields << "#{ftag}\t#{fname}\t#{frep}\t#{fcontext}"

  sfdata.each { |ln|
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
      sfrep = ''
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

