#!/usr/bin/env ruby
# George Wright, 2013
# Correct as-at 31/July/2013

require 'mechanize'
require 'hpricot'
require 'htmlentities'
require 'json'
require 'fastercsv'

BASE_URL = "http://www.aph.gov.au/Senators_and_Members/"
DELIM = "|"

outfile = File.new("output.csv","w+")

def fetch_az_list(page, outfile)
	agent = Mechanize.new(){ |agent|
		agent.history.max_size = 0
	}


	#@alpha.each do |letter|
	#puts "******** #{letter} ********\n"
	page = agent.get(BASE_URL + "/Parliamentarian_Search_Results?page=#{page}&expand=1&q=&mem=1&sen=1&par=-1&gen=0&ps=100")

	response = page.content.gsub(/\s+/m," ")
	#response = response.gsub(/\r/m,"\n")
	#response = response.gsub(/\n+/m,"\n")

	doc = Hpricot(response)

	list = []
	doc.search("ul.search-filter-results.search-filter-results-thumbnails li").map {|a| list << a} #['href']}

	list.each do |location|
		name = location.search("p.title a").inner_html.to_s.strip
		url = BASE_URL + location.search("p.title a")[0]['href']
		id = url.match(/MPID=(.*)$/)[1]
		thumbnail = location.search("p.thumbnail a img")[0]['src']

		#labels = location.search("dl dt") 
		#data = location.search("dl dd") 
		data = []
		type = ""

		i = 0
		location.search("dl").each {|item|

			item.children.each {|value|
				value = value.to_s.strip
				if value.match("<dt>")
					key = value.match("<dt>(.*)</dt>")[1]

					case key
					when "Member for"
						i = 0
						type = "Member"
					when "Senator for"
						i = 0
						type = "Senator"
					when "Party"
						i = 1
					when "Title(s)"
						i = 2
					when "Connect"
						i = 3
					end
				elsif value.match("<dd>")
					if data[i].nil?
						data[i] = value.match("<dd>(.*)</dd>")[1] 
					else
						data[i] = [data[i],value.match("<dd>(.*)</dd>")[1]].join("; ")
					end
				end
				
			}
			names = get_names(name)
			outfile.puts [name,type,url,id,thumbnail,data[0],data[1],data[2],names[0],names[1]].join("|")
		}
	end

	list.clear
	
	doc = nil
	response = nil
	page = nil
end

def get_names(value)
	value.gsub!(/^Senator /,"")
	value.gsub!(/^Senator /,"")
	value.gsub!(/^Mr /,"")
	value.gsub!(/^Mrs /,"")
	value.gsub!(/^Ms /,"")
	value.gsub!(/^[t|T]he Hon /,"")
	value.gsub!(/^Hon /,"")
	value.gsub!(/^Dr /,"")

	value.gsub!(/\,? MP$/,"")
	value.gsub!(/ AM$/,"")
	value.gsub!(/ AO$/,"")
	value.gsub!(/ QC$/,"")
	value.gsub!(/ SC$/,"")
	value.gsub!(/ OAM$/,"")

	values = (clean(value)).split(" ")
	firstname = values.first.strip
	lastname = values.last(values.count - 1).join(" ").strip
	return [firstname,lastname]
end


def clean(val)
	val =	val.gsub(/\r|\n/,"")
	val = val.gsub(/\u00A0/u," ")
	val = val.gsub(/&#39;/,"'")
	val = val.gsub("&nbsp;"," ")
	return val
end

outfile.puts ["member_name","member_type","url","pid","thumbnail","seat","party","title","firstname","lastname"].join(DELIM)
fetch_az_list(1,outfile)
fetch_az_list(2,outfile)
fetch_az_list(3,outfile)
outfile.close
