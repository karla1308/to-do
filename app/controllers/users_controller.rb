class UsersController < ApplicationController
  #skip the require_login check for new and create actions
  skip_before_action :require_login, only: [:new, :create]

  #render the user registration form
  def new
    @user = User.new
  end

  #create a new user and log them in
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id  #store user ID in session
      redirect_to todos_path, notice: "Account created successfully!"  #redirect to todos path
    else
      render :new, status: :unprocessable_entity  #re-render form if there's an error
    end
  end

  #show the current user's profile
  def profile
    @user = current_user
  end

  #delete the current user's account and log them out
  def destroy
    current_user.destroy  #delete user
    session.delete(:user_id)  #remove user ID from session
    redirect_to root_path, notice: "Account deleted."  #redirect to homepage
  end

  def destroy_account
    current_user.destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Your account has been permanently deleted."
  end

  private

  #define permitted parameters for user creation
  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end
end
