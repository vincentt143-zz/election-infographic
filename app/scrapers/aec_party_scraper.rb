# Grabs a list of all political parties that ran for the election
# from the Australian Electoral Commission website

require 'nokogiri'
require 'open-uri'

Party.delete_all

doc = Nokogiri::HTML(open("http://www.aec.gov.au/parties_and_representatives/party_registration/Registered_parties/"))

list = []

doc.search("strong.r-party a").map {|a| list << a}

list.each {|p|
  party = Party.new
  party.name = p.inner_html
  party.save
}