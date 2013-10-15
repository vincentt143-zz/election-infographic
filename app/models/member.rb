class Member < ActiveRecord::Base
  belongs_to :party
  belongs_to :electorate

  validates_presence_of :first_name, :last_name
end
