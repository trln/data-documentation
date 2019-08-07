outlines = ["Prepipeline label\tElement name\tEndeca dmod name\tFacet on element?\tIndexed in"]

pp_data = {}
File.open('endeca_prepipeline_name_to_dmod_element.tsv', 'r').each_line { |ln|
  ln.chomp!
  if ln.start_with?('Prepipeline Label')
    next
  elsif /^$/.match(ln)
    next
  else
    m = /^(.*?)\t(.*)$/.match(ln)
    pplabel = m[1]
    dmodname = m[2]
    if pp_data.has_key?(pplabel)
      pp_data[pplabel] << dmodname
    else
      pp_data[pplabel] = [dmodname]
    end
  end
}


el_data = {}
File.open('_endeca_final_elements_compiled.tsv', 'r').each_line { |ln|
  ln.chomp!
  if ln.start_with?('Element name')
    next
  elsif /^$/.match(ln)
    next
  else
    m = /^(.*?)\t(.*?)\t(.*)$/.match(ln)
    dmodname = m[2]
    other = [m[1], m[3]]
    el_data[dmodname] = other
  end
}

pp_data.each_pair { |ppl, dmodname|
  dmodname.each { |dn|
    puts "#{ppl.inspect}: #{dn.inspect}"
    edata = el_data[dn]
    outlines << "#{ppl}\t#{edata[0]}\t#{dn}\t#{edata[1]}"
  }
}

 open('_endeca_prepipeline_name_to_element.tsv', 'w') { |f|
   outlines.each { |ln|
     f.puts ln
   }
 }
