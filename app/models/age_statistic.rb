class AgeStatistic < ActiveRecord::Base
  belongs_to :electorate

  validates_presence_of :ones, :tens, :twenties, :thirties, :forties, :fifties, :sixties, :seventies_plus, :electorate_id
end
