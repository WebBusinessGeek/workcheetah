class TodosController < ApplicationController
  respond_to :html, :js

  def new
    @todo = Todo.new
  end

  def index
    if params[:date] && user_signed_in?
      @todos = current_user.todos.where(date: Date.parse(params[:date]))
    end
  end

  def create
    @todo = current_user.todos.build(todo_params)

    if @todo.save
      respond_with @todo
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
  end

  def sort
  end

  def complete
    @todo = Todo.find(params[:id])
    @todo.update_attributes done: true if params["checked"] == "true"
    @todo.update_attributes done: false if params["checked"] == "false"
    render nothing: true
  end

  private
    def todo_params
      params.require(:todo).permit(:date, :title, :done)
    end
end
