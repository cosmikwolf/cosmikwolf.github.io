require 'json'
require 'awesome_print'
#file = File.read('aapl_msft_googl.json')
file = File.read('top10MktCap2015.json')

data_hash = JSON.parse(file)

 exportHash = Hash.new


#for i in 0..1000 do
for i in 0..data_hash["result"]["totalrows"]-1 do
  ticker = data_hash['result']['rows'][i]["values"][2]["value"];
  if !exportHash.has_key?(ticker)
     exportHash[ticker] = Array.new
  end
  exportHash[ticker].push( {data_hash['result']['rows'][i]["values"][9]["value"] => data_hash['result']['rows'][i]["values"][20]["value"] } );
end


  puts '{'
  puts '  "name": "techMoney",'
  puts '  "children": ['
exportHash.each_with_index do |(key, value), index|
  puts '  {'
  puts '    "name": "' + key + '",'
  puts '    "children": ['
  exportHash[key].each_with_index do |x, y|
  print '      {"name": "' +  x.first[0].to_s.delete('\\') + ' " , "size": '+ x.first[1].to_int.to_s + ' }'
    if y == exportHash[key].size-1
      puts ''
    else
      puts ','
    end

  end
  puts '     ]'
  print '   }'
  if index == exportHash.size-1
    puts ''
  else
    puts ','
  end
end
puts '  ]'
puts '}'

#{}"name": "cluster",
#{}"children": [
 #{}{"name": "AgglomerativeCluster", "size": 3938},
 #{}{"name": "CommunityStructure", "size": 3812},
 #{}{"name": "HierarchicalCluster", "size": 6714},
 #{}{"name": "MergeEdge", "size": 743}
#{}]

#  data_hash['result']['rows'][i]["values"][2]["value"]
#  ap data_hash['result']['rows'][i]["values"][9]["value"]
#  ap data_hash['result']['rows'][i]["values"][20]["value"]
