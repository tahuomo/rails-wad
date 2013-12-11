class Style < ActiveRecord::Base
  attr_accessible :description, :name

  validates_presence_of :name, :description

  has_many :beers

  def to_s
    "#{name}"
  end
end
