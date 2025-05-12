class TodosController < ApplicationController
  #set the todo for actions like show, edit, update, and destroy
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  #display all todos for the current user, including their categories
  def index
    @todos = current_user.todos.includes(:category)
  end

  #show a single todo
  def show
  end

  #initialize a new todo for the current user and load categories
  def new
    @todo = current_user.todos.new
    @categories = current_user.categories
  end

  #create a new todo and save it to the database
  def create
    @todo = current_user.todos.new(todo_params)

    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'To-do was successfully created.' }  #redirect to the created todo
      else
        @categories = current_user.categories  #load categories for the form
        format.html { render :new, status: :unprocessable_entity }  #re-render the form with errors
      end
    end
  end

  #edit an existing todo and load categories for selection
  def edit
    @categories = current_user.categories
  end

  #update an existing todo and save changes
  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "To-do updated!"  #redirect to the updated todo
    else
      @categories = current_user.categories  #load categories for the form
      render :edit, status: :unprocessable_entity  #re-render the form with errors
    end
  end

  #toggle the completion status of a todo
  def complete
    @todo = current_user.todos.find(params[:id])
    @todo.update(completed: !@todo.completed)  #toggle completed status
    redirect_to todos_path  #redirect to todos list
  end

  #display all completed todos for the current user
  def completed
    @todos = current_user.todos.where(completed: true)
  end

  #delete a todo
  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "To-do deleted."  #redirect to todos list
  end

  private

  #set the todo for show, edit, update, and destroy
  def set_todo
    @todo = current_user.todos.find(params[:id])
  end

  #define allowed parameters for todo creation and update
  def todo_params
    params.require(:todo).permit(:title, :priority, :completed, :category_id)
  end
end
