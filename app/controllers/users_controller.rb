# app/controllers/users_controller.rb

class UsersController < ApplicationController
    before_action :set_user, only: [:show]
   

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
      
  
    def show
      render json: @user
    end
  
    private
  
    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
  
    def set_user
      @user = User.find(params[:id])
    end
  end
  