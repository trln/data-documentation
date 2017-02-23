Sfmap = Struct.new(:ee, :tag, :sf, :i1, :i2, :constraint, :inst)
sfsmapped = []
tagsmapped = {}
File.open('marc_to_endeca.tsv', 'r').each_line { |ln|
  ln.chomp!
  if ln.start_with?('Endeca Element')
    next
  else
    f = ln.split(/\t/)
    ee = f[0]
    tag = f[1]
    i1 = f[2]
    i2 = f[3]
    constraint = f[4]
    sfs = f[5]
    inst = f[6]

    sfs.each_char { |sf|
      sfsmapped << Sfmap.new(ee, tag, sf, i1, i2, constraint, inst)
    }

    taginfo = ""
    if i1 != '.' && i2 != '.'
      taginfo << "WHEN i1=#{i1} AND i2=#{i2}"
    elsif i1 != '.'
      taginfo << "WHEN i1=#{i1}"
    elsif i2 != '.'
      taginfo << "WHEN i2=#{i2}"
    end

    taginfo << ", " unless taginfo == ''
    
    if constraint != '.'
      if i1 != '.' || i2 != '.'
        taginfo << " AND #{constraint}, "
      else
        taginfo << "WHEN #{constraint}, "
      end
    end

    taginfo << "#{sfs} -> #{ee}"

    if tagsmapped.has_key?(tag)
      tagsmapped[tag] << taginfo
    else
      tagsmapped[tag] = [taginfo]
    end
  end
}

sfsmapped.each { |sf|
#  puts "#{sf[:tag]} #{sf[:sf]}"
}

tagsmapped.each_pair { |t, i|
#  puts "#{t}: #{i.to_s}"
}

open('_marc_bib_tags_mapped.tsv', 'w') { |outfile|
  outlns = []
  File.open('_marc_bib_tags.tsv', 'r').each_line { |ln|
    ln.chomp!
    line = ln.split(/\t/)
    if line[0] == 'MARC tag'
      line << 'Endeca mappings'
    else
      t = line[0]
      if tagsmapped.has_key?(t)
        maps = tagsmapped[t].join(';;;')
        line << maps
      else
        line << 'not mapped to Endeca'
      end
    end
    outlns << line
  }
  outlns.each { |ln| outfile.puts ln.join("\t") }
}
