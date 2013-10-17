class ReligionStatistic < ActiveRecord::Base
  belongs_to :electorate

  validates_presence_of :christianity, :buddhism, :judaism, :islam, :hinduism, :no_religion, :other, :electorate_id
end
