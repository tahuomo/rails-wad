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
    @rating = Rating.create params[:rating]
    if @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find params[:id]
    rating.delete if currently_signed_in?(rating.user)
    redirect_to :back
  end



end