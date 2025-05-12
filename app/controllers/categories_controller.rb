class CategoriesController < ApplicationController
  #set the category for actions
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  #display all categories for the current user
  def index
    @categories = current_user.categories
  end

  #display a single category and its associated todos
  def show
    @todos = @category.todos
  end

  #initialize a new category for the current user
  def new
    @category = current_user.categories.new
  end

  #create a new category and save it to the database
  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to @category, notice: "Category created!"  # Redirect to the new category page
    else
      render :new, status: :unprocessable_entity  # Re-render the form with errors
    end
  end

  #edit an existing category
  def edit
  end

  #update an existing category and save changes
  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Category updated!"  # Redirect to the updated category page
    else
      render :edit, status: :unprocessable_entity  # Re-render the form with errors
    end
  end

  #delete an existing category
  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Category deleted."  # Redirect to the categories index page
  end

  private

  #set the category for show, edit, update, and destroy actions
  def set_category
    @category = current_user.categories.find(params[:id])
  end

  #define allowed parameters for category creation and update
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
