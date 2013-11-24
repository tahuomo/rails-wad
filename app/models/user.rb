class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation
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
end
