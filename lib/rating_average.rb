module RatingAverage


  def average_rating
    if ratings.empty?
      return
    end
    ratings.average("score")
  end
end