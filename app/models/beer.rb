class Beer < ActiveRecord::Base
  include RatingAverage

  attr_accessible :brewery_id, :name, :style_id

  validates_presence_of :name, :style_id

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  has_many :raters, :through => :ratings, :source => :user

  def to_s
    name + ", " + brewery.name
  end
end
