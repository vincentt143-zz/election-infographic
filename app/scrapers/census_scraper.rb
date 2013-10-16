# Grabs the Basic Community Profiles of
# Australians

require 'roo'

Dir.glob('db/census_data/*.XLS') do |data|
  xl = Roo::Excel.new(data)
  xl.default_sheet = xl.sheets[0]
  name = xl.cell(9, 'B')
  name = /^\s*[^,]+/.match(name)
  electorate = Electorate.find_by(:name => "#{name}")

  xl.default_sheet = xl.sheets[10]

  gender = GenderStatistic.new
  gender.males = xl.cell(41, 'L')
  gender.females = xl.cell(41, 'M')
  gender.electorate = electorate
  gender.save
  age = AgeStatistic.new
  age.ones = xl.cell(16, 'D') + xl.cell(22, 'D')
  age.tens = xl.cell(28, 'D') + xl.cell(34, 'D')
  age.twenties = xl.cell(40, 'D') + xl.cell(46, 'D')
  age.thirties = xl.cell(16, 'I') + xl.cell(22, 'I')
  age.fourties = xl.cell(28, 'I') + xl.cell(34, 'I')
  age.fifties = xl.cell(40, 'I') + xl.cell(46, 'I')
  age.sixties = xl.cell(16, 'N') + xl.cell(22, 'N')
  age.seventies_plus = xl.cell(28, 'N') + xl.cell(34, 'N') +  xl.cell(35, 'N') + xl.cell(36, 'N') + xl.cell(37, 'N') + xl.cell(38, 'N')
  age.electorate = electorate
  age.save

end
