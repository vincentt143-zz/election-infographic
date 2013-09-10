class Party < ActiveRecord::Base
  has_many :members

  field :name, :type => String
  field :members, :type => Member
end
