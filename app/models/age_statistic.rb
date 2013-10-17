class AgeStatistic < ActiveRecord::Base
  belongs_to :electorate

  validates_presence_of :under_twenty_five, :twenty_five_to_thirty_nine, :forties, :fifties, :sixty_plus
end
