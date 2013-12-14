class Brewery < ActiveRecord::Base
  include RatingAverage

  attr_accessible :name, :year, :active

  validates_presence_of :name
  validates_numericality_of :year, { :greater_than_or_equal_to => 1042,
                                      :only_integer => true }
  validate :year_cannot_be_in_the_future

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  scope :active, where(:active => true)
  scope :retired, where(:active => [nil, false])

  def year_cannot_be_in_the_future
    if year > Date.today.year
      errors.add(:year, "can't be greater than #{Date.today.year}")
    end
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -b.average_rating }.first(n)
  end

  def to_s()
    "#{name}"
  end
end
