class ApplicationController < ActionController::Base
  #ensure the user is logged in before accessing any action
  before_action :require_login
  
  private
  
  #redirect to login page if the user is not logged in
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please login to access this page."
    end
  end
  
  #check if the user is logged in
  def logged_in?
    !!current_user
  end
  
  #retrieve the current user from the session
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #make current_user and logged_in? available in views
  helper_method :current_user, :logged_in?
end