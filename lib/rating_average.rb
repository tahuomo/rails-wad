module RatingAverage


  def average_rating
    avg = ratings.average(:score)
    if avg.nil?
      0
    else
      avg
    end
  end
end