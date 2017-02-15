outlines = ["Element name\tIndexed in"]

File.open('endeca_indexing.tsv', 'r').each_line { |ln|
  ln.chomp!
  if ln.start_with?('Element name')
    next
  else
    m = /^(.*?)\t(.*)$/.match(ln)
    element = m[1]
    indin = m[2].split(/\t/)
    indin.keep_if { |i| i.size > 0 }
    indin.sort!
    outlines << "#{element}\t#{indin.join(', ')}"
  end
}

 open('_endeca_indexing_reduced.tsv', 'w') { |f|
   outlines.each { |ln|
     f.puts ln
   }
 }

