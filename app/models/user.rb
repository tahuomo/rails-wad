class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation, :admin
  has_secure_password

  validates_uniqueness_of :username
  validates_length_of :username, :minimum => 3, :maximum => 15
  validates_length_of :password, :minimum => 4
  validates_format_of :password, :with => /[^A-Za-z]/i, :message => "Must contain non-alphabetic characters"

  has_many :ratings, :dependent => :destroy
  has_many :beers, :through => :ratings
  has_many :memberships
  has_many :beer_clubs, :through => :memberships


  def to_s
    "#{username}"
  end

  def favorite_beer
    return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole

    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    return calculate_best_average_from :style
  end

  def favorite_brewery
    return calculate_best_average_from :brewery
  end

  private

  def calculate_best_average_from feature
    return nil if ratings.empty?
    hash = ratings.group_by{|r| r.beer.send(feature)}
    hash.keys.each do |key|
      sum = 0;
      hash[key].each {|a| sum += a.score}
      hash[key] = sum / hash[key].count
    end
    return hash.key(hash.values.max)
  end

  def self.top_raters(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |u| -u.ratings.count }.first(n)
  end

end
