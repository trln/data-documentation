Sfmap = Struct.new(:ee, :tag, :sf, :i1, :i2, :constraint, :inst)
sfsmapped = []

# {tag =>
#   { summary => [string, string],
#   { exploded => [array, array]
# }
tag_mappings = {}
tag_mappings['na'] = {:summary => 'not mapped to Endeca', :exploded => [['na', 'na', 'na', 'na', 'na', 'na']]}

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

    # create summary/verbose/one line tag mappings
    tag_map_summary = ""
    tag_map_summary << "(#{inst}): "
    if i1 != '.' && i2 != '.'
      tag_map_summary << "WHEN i1=#{i1} AND i2=#{i2}"
    elsif i1 != '.'
      tag_map_summary << "WHEN i1=#{i1}"
    elsif i2 != '.'
      tag_map_summary << "WHEN i2=#{i2}"
    end
    tag_map_summary << ", " unless tag_map_summary.end_with?('): ')
    if constraint != '.'
      if i1 != '.' || i2 != '.'
        tag_map_summary << " AND #{constraint}, "
      else
        tag_map_summary << "WHEN #{constraint}, "
      end
    end
    tag_map_summary << "#{sfs} -> #{ee}"

    # populate tag_mappings hash
    if tag_mappings.has_key?(tag)
      tag_mappings[tag][:summary] << ";;;#{tag_map_summary}"
      tag_mappings[tag][:exploded] << [ee, i1, i2, constraint, sfs, inst]
    else
      tag_mappings[tag] = {:summary => tag_map_summary, :exploded => [[ee, i1, i2, constraint, sfs, inst]]}
    end
  end
}

sfsmapped.each { |sf|
#  puts "#{sf[:tag]} #{sf[:sf]}"
}

tag_mappings.each_pair { |t, i|
#  puts "#{t}: #{i.to_s}"
}


tag_sum = File.open('_marc_bib_tags_mapped_summary.tsv', 'w')
tag_expl = File.open('_marc_bib_tags_mapped_exploded.tsv', 'w')

# for each MARC tag listed in standard... 
File.open('../marc/_marc_bib_tags.tsv', 'r').each_line { |ln|
  ln.chomp!
  line = ln.split(/\t/)
  explosion = []
  if line[0] == 'MARC tag'
    summ_line = line.clone << 'Endeca mappings'
    expl_line = line.clone << ['Endeca element', 'subfields mapped', 'i1 constraint', 'i2 constraint', 'other constraint', 'institution']
    expl_line.flatten!
    explosion << expl_line
  else
    mtag = line[0]
    if tag_mappings.has_key?(mtag)
      lkup_tag = mtag
    else
      lkup_tag = 'na'
    end
    summ_line = line.clone << tag_mappings[lkup_tag][:summary]
    tag_mappings[lkup_tag][:exploded].each { |v|
      poof = line.clone << v
      explosion << poof.flatten
    }
  end

  explosion.each { |poof|
    tag_expl.puts poof.join("\t")
  }

  tag_sum.puts summ_line.join("\t")
}

tag_sum.close
tag_expl.close
