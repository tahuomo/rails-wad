class BeermappingAPI
  def self.places_in(city)
    Place # varmistaa, että luokan koodi on ladattu
    Time

    city = city.downcase
    Rails.cache.write city, [fetch_places_in(city), Time.now] if not Rails.cache.exist? city or (Rails.cache.read city)[1] < 1.hour.ago

    (Rails.cache.read city)[0]
  end

  def self.find_place_by_id(id)
      fetch_place_by_id(id);
  end


  def self.find_scores_by_id(id)
    url = "http://beermapping.com/webservice/locscore/#{key}/#{id}"
    response = HTTParty.get url
    response.parsed_response["bmp_locations"]["location"]
  end


  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.fetch_place_by_id(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/"
    response = HTTParty.get "#{url}#{id}"
    places = response.parsed_response["bmp_locations"]["location"]

    return nil if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    return Place.new(places.first.merge find_scores_by_id(id))
  end

  def self.key
    Settings.beermapping_apikey
  end
end