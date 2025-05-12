class LandingController < ApplicationController
  #skip the require_login check for actions in this controller
  skip_before_action :require_login
  
  #redirect to todos path if user is logged in, otherwise display welcome page
  def welcome
    redirect_to todos_path if logged_in?  #redirect to todos if the user is logged in
  end

  #redirect to the welcome page if the user is not logged in
  def getstarted
    redirect_to welcome_landing_path unless logged_in?  #redirect to welcom page if not logged in
  end
end
