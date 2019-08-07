Sfmap = Struct.new(:ee, :tag, :sf, :i1, :i2, :constraint, :inst)
mapped_sfs = []

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
      mapped_sfs << Sfmap.new(ee, tag, sf, i1, i2, constraint, inst)
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

tag_sum = File.open('_marc_bib_tags_mapped_summary.tsv', 'w')
tag_expl = File.open('_marc_bib_tags_mapped_exploded.tsv', 'w')
mapped_sf_out = File.open('_marc_bib_sfs_mapped.tsv', 'w')
unmapped_sf_out = File.open('_marc_bib_sfs_UNmapped.tsv', 'w')


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

marc_sfs = {}
mapped_sf_out.puts ("MARC tag\tField name\tField repeatability\tField note\tSF delimiter\tSF name\tSF repeatability\tSF note\tSubfield\tEndeca element\ti1\ti2\tOther constraint\tInstitution")
unmapped_sf_out.puts ("MARC tag\tField name\tField repeatability\tField note\tSF delimiter\tSF name\tSF repeatability\tSF note\tSubfield")

File.open('../marc/_marc_bib_subfields.tsv', 'r').each_line { |ln|
  ln.chomp!
  line = ln.split(/\t/)
  ftag = line[0]
  fname = line[1]
  frep = line[2]
  fnote = line[3]
  sfdel = line[4]
  sfname = line[5]
  sfrep = line[6]
  sfnote = line[7]
  thesf = ftag + sfdel

  next if ftag == 'MARC tag'
  
  if tag_mappings.has_key?(ftag)
    mysfs = mapped_sfs.select { |sf| sf[:tag] == ftag && sf[:sf] == sfdel }
    
    if mysfs.size > 0
      #Sfmap = Struct.new(:ee, :tag, :sf, :i1, :i2, :constraint, :inst)
      mysfs.each { |sf|
        out_line = line.clone
        out_line << [thesf, sf[:ee], sf[:i1], sf[:i2], sf[:constraint], sf[:inst]]
        out_line.flatten!
        mapped_sf_out.puts out_line.join("\t")
      }
    else
      out_line = line.clone
      out_line << thesf
      unmapped_sf_out.puts out_line.join("\t")
    end
  end

}


tag_sum.close
tag_expl.close
mapped_sf_out.close
unmapped_sf_out.close
