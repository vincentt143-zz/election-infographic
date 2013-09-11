#!/usr/bin/env ruby
# George Wright, 2013
# Some changes made to save the member to the database

require 'mechanize'
require 'hpricot'
require 'htmlentities'
require 'json'
require 'fastercsv'

BASE_URL = "http://www.aph.gov.au/Senators_and_Members"

def fetch_az_list(page)
	agent = Mechanize.new(){ |agent|
		agent.history.max_size = 0
	}


	page = agent.get(BASE_URL + "/Parliamentarian_Search_Results?page=#{page}&expand=1&q=&mem=1&par=-1&gen=0&ps=100")

	response = page.content.gsub(/\s+/m," ")

	doc = Hpricot(response)

	list = []
	doc.search("ul.search-filter-results.search-filter-results-thumbnails li").map {|a| list << a} 

	list.each do |location|
		name = location.search("p.title a").inner_html.to_s.strip

		data = []

		i = 0
		location.search("dl").each {|item|

			item.children.each {|value|
				value = value.to_s.strip
				if value.match("<dt>")
					key = value.match("<dt>(.*)</dt>")[1]

					if key == "Party"
						i = 1
          elsif key == "Title(s)"
						i = 2
          elsif key == "Connect"
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

      member = Member.new
      member.first_name = names[0]
      member.last_name = name[1]
      member.party = data[1]
      member.electorate = data[0].split(',').first
      member.title = data[2]

      member.save

		}
	end

	list.clear

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
	first_name = values.first.strip
	last_name = values.last(values.count - 1).join(" ").strip
	[first_name,last_name]
end


def clean(val)
	val =	val.gsub(/\r|\n/,"")
	val = val.gsub(/\u00A0/u," ")
	val = val.gsub(/&#39;/,"'")
	val.gsub("&nbsp;"," ")
end

fetch_az_list(1)
fetch_az_list(2)
fetch_az_list(3)
