# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

load 'aec_party_scraper.rb'
load 'aec_electorate_scraper.rb'
load 'member_scraper.rb'
load 'census_scraper.rb'
load 'election_results_scraper.rb'