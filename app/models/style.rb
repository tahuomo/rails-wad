class Style < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :beers
end
