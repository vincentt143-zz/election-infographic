class GenderStatistic < ActiveRecord::Base
  belongs_to :electorate

  validates_presence_of :males, :females, :electorate_id
end
