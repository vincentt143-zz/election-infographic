class Electorate < ActiveRecord::Base
  has_many :member
  has_many :parties

end
