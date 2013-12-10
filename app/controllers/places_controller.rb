class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingAPI.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, :notice => "No locations in #{params[:city]}"
    else
      session[:last_places] = "#{params[:city]}"
      render :index
    end
  end

  def show
    @place = BeermappingAPI.find_place_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @beer }
    end
  end

end