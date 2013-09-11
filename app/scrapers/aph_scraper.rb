# Grabs a list of all members of the House of Representatives from
# the Australian Parliament House website

require 'nokogiri'
require 'open-uri'

def fetch_az_list(page)

  doc = Nokogiri::HTML(open("http://www.aph.gov.au/Senators_and_Members/Parliamentarian_Search_Results?page=#{page}&expand=1&q=&mem=1&par=-1&gen=0&ps=100"))

  list = []
  doc.search("ul.search-filter-results.search-filter-results-thumbnails li").map {|a| list << a} 

  list.each do |location|
    name = location.search("p.title a").inner_html.to_s.strip
    names = get_names(name)

    member = Member.new
    member.first_name = names[0]
    member.last_name = names[1]

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
        elsif value.match("<dd>") and i != 3 # A temporary solution to not being able to add contact details
          if data[i].nil?
            data[i] = value.match("<dd>(.*)</dd>")[1]
          else
            data[i] = [data[i],value.match("<dd>(.*)</dd>")[1]].join("; ")
          end
        end
      }
      member.party_id = Party.find_by(:name => data[1]).object_id
      #member.electorates = data[0].split(',').first
      member.title = data[2]

      member.save

    }
  end

  list.clear

end

def get_names(value)
  value.gsub!(/^(Mr|Mrs|Ms|[t|T]he Hon|Hon|Dr|) /,"")

  value.gsub!(/(\,? MP| AM| AO| QC| SC| OAM)$/,"")

  values = (clean(value)).split(" ")
  first_name = values.first.strip
  last_name = values.last(values.count - 1).join(" ").strip
  [first_name,last_name]
end


def clean(val)
  val = val.gsub(/\r|\n/,"")
  val = val.gsub(/\u00A0/u," ")
  val = val.gsub(/&#39;/,"'")
  val.gsub("&nbsp;"," ")
end

Member.delete_all
fetch_az_list(1)
fetch_az_list(2)
