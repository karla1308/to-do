class SessionsController < ApplicationController
  #skip the require_login check for new and create actions
  skip_before_action :require_login, only: [:new, :create]
  
  #render login form
  def new
    #login form renders automatically
  end
  
  #authenticate user and log them in if credentials are valid
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id  # Store user ID in session
      redirect_to todos_path, notice: "Logged in successfully!"  #redirect to todos
    else
      flash.now[:alert] = "Invalid username or password"  #show error message
      render :new  #re-render the login form
    end
  end
  
  #log the user out by deleting the session
  def destroy
    session.delete(:user_id)  #remove user ID from session
    @current_user = nil  #clear current user
    redirect_to root_path, notice: "Logged out!"  #redirect to homepage
  end
end
