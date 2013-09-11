class Member < ActiveRecord::Base
  belongs_to :party
  belongs_to :electorate

  field :first_name, :type => String
  field :last_name, :type => String
  field :title, :type => String

  validates_presence_of :first_name, :last_name

  def initialize

  end

end
