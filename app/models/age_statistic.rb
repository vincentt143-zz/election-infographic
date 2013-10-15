class AgeStatistic < ActiveRecord::Base
  belongs_to :electorate

  validates_presence_of :ones, :tens, :twenties, :thirties, :fourties, :fifties, :sixties, :seventies_plus, :electorate_id
end
