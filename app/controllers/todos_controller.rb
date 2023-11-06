# app/controllers/todos_controller.rb
class TodosController < ApplicationController
    before_action :set_user
    before_action :set_todo, only: [:show, :update, :destroy]
  
    def index
      @todos = @user.todos
      render json: @todos
    end
  
    def show
      render json: @todo
    end
  
    def create
      @todo = @user.todos.build(todo_params)
  
      if @todo.save
        render json: @todo, status: :created
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @todo.update(todo_params)
        render json: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @todo.destroy
      head :no_content
    end
  
    private
  
    def set_user
      @user = User.find(params[:user_id])
    end
  
    def set_todo
      @todo = @user.todos.find(params[:id])
    end
  
    def todo_params
      params.require(:todo).permit(:name, :done)
    end
  end
  