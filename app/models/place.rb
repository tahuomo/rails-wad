class Place
  attr_accessor :id, :name, :status, :reviewlink, :proxylink, :blogmap, :street, :city, :state, :zip, :country, :phone, :overall, :imagecount, :selection, :service, :atmosphere, :food, :reviewcount, :fbscore, :fbcount

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def self.rendered_fields
    [:status, :street, :city, :zip, :country, :overall ]
  end

  def self.score_fields
    [:overall, :selection, :service, :atmosphere, :food, :reviewcount, :fbscore, :fbcount]
  end
end