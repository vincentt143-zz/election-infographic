# Grabs a list of all electorates in Australia
# from the Australian Electoral Commission website

require 'nokogiri'
require 'open-uri'

Electorate.delete_all

doc = Nokogiri::HTML(open("http://www.aec.gov.au/profiles/"))

list = []

doc.search("td a").map {|a| list << a}

list.each {|e|
  if e.inner_html.match('Profile of electorate of')
    electorate = Electorate.new
    electorate.name = e.inner_html.match('Profile of electorate of (.*)')[1]
    electorate.save
  end

}

electorate = Electorate.new
electorate.name = "Australia"
electorate.save