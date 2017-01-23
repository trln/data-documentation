outlines = ["Element name\tEndeca dmod name\tFacet on element?\tIndexed in"]

pp_data = {}
File.open('endeca_prepipeline_name_to_dmod_element.tsv', 'r').each_line { |ln|
  ln.chomp!
  if ln.start_with?('Prepipeline Label')
    next
  else
    m = /^(.*?)\t(.*)$/.match(ln)
    pplabel = m[1]
    element = m[2]
    if pp_data.has_key?(pplabel)
      pp_data[pplabel] << element
    else
      pp_data[pplabel] = [element]
    end
  end
}

puts pp_data.inspect
# dim_list = []
# File.open('endeca_dimensions.tsv', 'r').each_line { |ln|
#   ln.chomp!
#   if ln.start_with?('Dimension name')
#     next
#   else
    
#     dim_list << m[1]
#   end
# }

# File.open('endeca_final_elements.tsv', 'r').each_line { |ln|
#   ln.chomp!
#   if ln.start_with?('Endeca element name')
#     next
#   else
#     m = /^(.*?)\t(.*)$/.match(ln)
#     element = m[1]
#     dmodname = m[2]
#     if dim_list.include?(element)
#       facet = 'yes'
#     else
#       facet = 'no'
#     end
#     if ind_data.has_key?(element)
#       indin = ind_data[element]
#     else
#       indin = 'not indexed'
#     end
#   end
#     outlines << "#{element}\t#{dmodname}\t#{facet}\t#{indin}"
# }


#  open('_endeca_final_elements_compiled.tsv', 'w') { |f|
#    outlines.each { |ln|
#      f.puts ln
#    }
#  }
