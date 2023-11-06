# app/controllers/items_controller.rb
class ItemsController < ApplicationController
    before_action :set_todo
    before_action :set_item, only: [:show, :update, :destroy]
  
    def create
      @item = @todo.items.build(item_params)
  
      if @item.save
        render json: @item, status: :created
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @item.update(item_params)
        render json: @item
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @item.destroy
      head :no_content
    end
  
    private
  
    
  
    def set_todo
        @todo = Todo.find(params[:todo_id])
      end
    def set_item
      @item = @todo.items.find(params[:id])
    end
  
    def item_params
      params.require(:item).permit(:name, :price)
    end
  end
  