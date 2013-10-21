# Grabs the two-way party preferred voting results
# from the AEC Virtual Tally Room

require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://vtr.aec.gov.au/HouseTppByDivision-17496-NAT.htm"))

list = []
doc.search("//tr[@class='rownorm']").map {|a| list << a}
list.each do |e|
  data = e.search("td")
  name = e.search("td a").inner_html
  electorate = Electorate.find_by(:name => "#{name}")
  next if electorate == nil

  electorate.labor_votes = Integer(data[2].inner_html.gsub(/,/, ""))
  electorate.labor_percentage = Float(data[3].inner_html.gsub(/,/, ""))/100
  electorate.liberal_votes = Integer(data[4].inner_html.gsub(/,/, ""))
  electorate.liberal_percentage = Float(data[5].inner_html.gsub(/,/, ""))/100
  electorate.save
end

doc = Nokogiri::HTML(open("http://vtr.aec.gov.au"))
electorate = Electorate.find_by(:name => "Australia")
list = []
doc.search("//tr[@id='repeaterTpp__ctl0_tppRow']").map {|a| list << a}
list.each do |e|
  data = e.search("td")
  electorate.labor_votes = Integer(data[1].inner_html.gsub(/,/, ""))
  electorate.labor_percentage = Float(data[2].inner_html.gsub(/,/, ""))/100
end

list = []
doc.search("//tr[@id='repeaterTpp__ctl1_tppRow']").map {|a| list << a}
list.each do |e|
  data = e.search("td")
  electorate.liberal_votes = Integer(data[1].inner_html.gsub(/,/, ""))
  electorate.liberal_percentage = Float(data[2].inner_html.gsub(/,/, ""))/100
end
electorate.save
