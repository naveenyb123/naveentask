# spec/controllers/items_controller_spec.rb

require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:todo) { create(:todo, user: user) } 
  let(:item) { create(:item, todo: todo) } 
  describe 'POST #create' do
    it 'creates a new item for the todo' do
      post :create, params: { user_id: user.id, todo_id: todo.id, item: { name: 'Sample Item', price: "9.99" } }
      expect(response).to have_http_status(:created)
    end

    it 'returns the created item in JSON' do
      post :create, params: { user_id: user.id, todo_id: todo.id, item: { name: 'Sample Item', price: "9.99" } }
      item = JSON.parse(response.body)
      expect(item['name']).to eq('Sample Item')
      expect(item['price']).to eq("9.99")
    end
  end

  describe 'PUT #update' do
    it 'updates an existing item for the todo' do
      new_name = 'Updated Item Name'
      put :update, params: { user_id: user.id, todo_id: todo.id, id: item.id, item: { name: new_name } }
      expect(response).to have_http_status(:ok)
      item.reload
      expect(item.name).to eq(new_name)
    end

    it 'returns the updated item in JSON' do
        put :update, params: { user_id: user.id, todo_id: todo.id, id: item.id, item: { price: 19.99 } }
        item = JSON.parse(response.body)
        expect(item['price'].to_f).to eq(19.99)  
      end
  end

  describe 'DELETE #destroy' do
    it 'deletes an item for the todo' do
      delete :destroy, params: { user_id: user.id, todo_id: todo.id, id: item.id }
      expect(response).to have_http_status(:no_content)
      expect { item.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
