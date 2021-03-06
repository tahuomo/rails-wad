class ApplicationController < ActionController::Base
  protect_from_forgery

  # määritellään, että metodi current_user tulee käyttöön myös näkymissä
  helper_method :current_user
  helper_method :currently_signed_in?

  def current_user
    return nil if session[:user_id].nil?
    return User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound => e
    return  nil
  end

  def currently_signed_in?(user)
    current_user == user
  end

  def ensure_that_signed_in
    redirect_to signin_path, :notice => 'you should be signed in' if current_user.nil?
  end

  def ensure_that_admin
    redirect_to breweries_path, :notice => 'You are not an admin' unless current_user.admin?
  end


end
