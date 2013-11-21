class RatingsController< ApplicationController
  def index
    @ratings = Rating.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ratings }
    end
  end

  def new
    @beers = Beer.all
    @rating = Rating.new
  end


  def create
    Rating.create params[:rating]
    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete
    redirect_to ratings_path
  end



end