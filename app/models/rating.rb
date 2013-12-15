

class Rating < ActiveRecord::Base
  attr_accessible :beer_id, :score

  belongs_to :beer
  belongs_to :user   # rating kuuluu myös käyttäjään

  validates_presence_of :beer_id
  validates_numericality_of :score, { :greater_than_or_equal_to => 1,
                                      :less_than_or_equal_to => 50,
                                      :only_integer => true }

  scope :recent, order("created_at desc").limit(5)

  def to_s
   "#{beer.name} #{score}"
  end



end