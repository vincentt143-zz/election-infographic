# Grabs the age and gender statistics from
# the Australian census data

require 'roo'

def extract(file)
  xl = Roo::Excel.new(file)
  xl.default_sheet = xl.sheets[0]
  name = xl.cell(9, 'B')
  name = /^\s*[^,(]+/.match(name).to_s
  name = name.gsub(/^\s*/, "")
  name = name.gsub(/\s*$/, "")
  electorate = Electorate.find_by(:name => "#{name}")

  xl.default_sheet = xl.sheets[10]

  gender = GenderStatistic.new
  gender.males = xl.cell(41, 'L')
  gender.females = xl.cell(41, 'M')
  gender.electorate = electorate
  gender.save
  age = AgeStatistic.new
  age.under_twenty_five = xl.cell(34, "D") - xl.cell(29, "D") + xl.cell(40, "D") - xl.cell(39, "D")
  age.twenty_five_to_thirty_nine = xl.cell(29, "D") + xl.cell(46, "D") + xl.cell(16, "I") + xl.cell(17, "I") + xl.cell(18, "I") + xl.cell(19, "I")
  age.forties = xl.cell(20, "I") + xl.cell(21, "I") + xl.cell(28, "I") + xl.cell(29, "I") + xl.cell(30, "I") + xl.cell(31, "I")
  age.fifties = xl.cell(32, "I") + xl.cell(33, "I") + xl.cell(40, "I") + xl.cell(41, "I") + xl.cell(42, "I") + xl.cell(43, "I")
  age.sixty_and_over = xl.cell(44, "I") + xl.cell(45, "I") + xl.cell(16, "N") + xl.cell(22, "N") + xl.cell(28, "N") + xl.cell(34, "N") + xl.cell(35, "N") + xl.cell(36, "N") + xl.cell(37, "N") + xl.cell(38, "N") + xl.cell(39, "N")
  age.electorate = electorate
  age.save

  xl.default_sheet = xl.sheets[24]
  religion = ReligionStatistic.new
  religion.christianity = xl.cell(32, "D")
  religion.buddhism = xl.cell(11, "D")
  religion.hinduism = xl.cell(33, "D")
  religion.islam = xl.cell(34, "D")
  religion.judaism = xl.cell(35, "D")
  religion.other = xl.cell(39, "D") + xl.cell(41, "D") + xl.cell(42, "D")
  religion.no_religion = xl.cell(40, "D")
  religion.electorate = electorate
  religion.save
end

GenderStatistic.delete_all
AgeStatistic.delete_all
ReligionStatistic.delete_all

Dir.glob('db/census_data/BCP_CED*.XLS') do |file|
  extract file
end

Dir.glob('db/census_data/BCP_0.XLS') do |file|

  extract file
end