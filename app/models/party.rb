class Party < ActiveRecord::Base
  has_many :members

  field :name, :type => String
  def initialize

  end
end
