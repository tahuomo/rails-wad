class BeerClub < ActiveRecord::Base
  attr_accessible :city, :founded, :name

  has_many :memberships
  has_many :members, :through => :memberships, :source => :user

  def to_s
    "#{name}, #{city}"
  end
end
