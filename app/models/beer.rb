class Beer < ActiveRecord::Base
  include RatingAverage

  attr_accessible :brewery_id, :name, :style_id

  validates_presence_of :name, :style_id

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, :dependent => :destroy
  has_many :raters, :through => :ratings, :source => :user

  def to_s
    name + ", " + brewery.name
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -b.average_rating }
    sorted_by_rating_in_desc_order.take(n)
  end
end
