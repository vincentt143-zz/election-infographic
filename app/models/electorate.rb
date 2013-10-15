class Electorate < ActiveRecord::Base
  has_many :members
  has_one :age_statistic
  has_one :gender_statistic
  validates_presence_of :name
end
