class Membership < ActiveRecord::Base
  attr_accessible :beer_club_id, :user_id, :confirmed

  belongs_to :beer_club
  belongs_to :user

  scope :confirmed, where(:confirmed => true)
  scope :unconfirmed, where(:confirmed => [nil, false])
end
