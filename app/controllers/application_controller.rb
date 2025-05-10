class ApplicationController < ActionController::Base
  before_action :require_login
  
  private
  
  def require_login
    unless logged_in?
      redirect_to login_path, alert: "Please log in to access this page."
    end
  end
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  helper_method :current_user, :logged_in?
end