class Member < ActiveRecord::Base
  belongs_to :parties
  belongs_to :electorates

  validates_presence_of :first_name, :last_name, :party_id
end
