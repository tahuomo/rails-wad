class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy


  def average_rating
    if ratings.empty?
      return
    end
    ratings.average("score")
  end

  def to_s
    name + ", " + brewery.name
  end
end
