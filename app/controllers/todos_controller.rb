class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]  # Fixed symbol array syntax

  def index
    @todos = current_user.todos.includes(:category)
  end

  def show
  end

  def new
    @todo = current_user.todos.new
    @categories = current_user.categories
  end

  def create
    @todo = current_user.todos.new(todo_params)
    
    respond_to do |format|  # Fixed typo (was |format!)
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
      else
        @categories = current_user.categories
        format.html { render :new, status: :unprocessable_entity }  # Fixed typo (was .entity)
      end
    end
  end

  def edit
    @categories = current_user.categories
  end

  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo updated!"
    else
      @categories = current_user.categories
      render :edit, status: :unprocessable_entity  # Fixed typo (was .entity)
    end
  end

  def complete
    @todo = current_user.todos.find(params[:id])
    @todo.update(completed: !@todo.completed)
    redirect_to todos_path
  end

  # def toggle_complete
  #   @todo = current_user.todos.find(params[:id])
  #   @todo.update(completed: !@todo.completed)
  #   redirect_to todos_path
  # end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "Todo deleted."
  end

  private

  def set_todo
    @todo = current_user.todos.find(params[:id])  # Fixed variable assignment (was (todo = )
  end

  def todo_params
    params.require(:todo).permit(:title, :priority, :completed, :category_id)
  end
end