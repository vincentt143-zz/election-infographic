class Electorate < ActiveRecord::Base
  has_many :member
  has_many :parties

  field :name, :type => String
  field :parties, :type => Party

  def initialize

  end
end
