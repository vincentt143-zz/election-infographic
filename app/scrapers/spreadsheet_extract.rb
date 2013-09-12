#!/usr/bin/env ruby
# Grabs the Basic Community Profiles of
# Australians

require 'rubygems'
require 'roo'

ARGV.each do|a|
  puts "Argument: #{a}"
end

xl = Excel.new("simple_spreadsheet.XLS")
xl.default_sheet = xl.sheets[7]
xl.first_row.upto(xl.last_row) do |line|
  stat       = xl.cell(line,'A')
  lineB      = xl.cell(line,'B')
  lineC      = xl.cell(line,'C')
  puts "#{stat}\t#{lineB}\t#{lineC}"
end
