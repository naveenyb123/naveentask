# spec/controllers/todos_controller_spec.rb
require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  let(:user) { create(:user) } # Assuming you have a User factory

  describe 'GET #index' do
    it 'returns a list of todos for the user' do
      todo = user.todos.create(name: 'Example Todo', done: false)
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(:ok)
      todos = JSON.parse(response.body)
      expect(todos.first['name']).to eq('Example Todo')
    end
  end

  describe 'GET #show' do
    it 'returns a specific todo for the user' do
      todo = user.todos.create(name: 'Example Todo', done: false)
      get :show, params: { user_id: user.id, id: todo.id }
      expect(response).to have_http_status(:ok)
      todo_response = JSON.parse(response.body)
      expect(todo_response['name']).to eq('Example Todo')
    end
  end

  describe 'POST #create' do
    it 'creates a new todo for the user' do
      todo_params = { name: 'New Todo', done: false }
      post :create, params: { user_id: user.id, todo: todo_params }
      expect(response).to have_http_status(:created)
      new_todo = JSON.parse(response.body)
      expect(new_todo['name']).to eq('New Todo')
    end
  end

  describe 'PUT #update' do
    it 'updates an existing todo for the user' do
      todo = user.todos.create(name: 'Old Todo', done: false)
      updated_params = { name: 'Updated Todo', done: true }
      put :update, params: { user_id: user.id, id: todo.id, todo: updated_params }
      expect(response).to have_http_status(:ok)
      updated_todo = JSON.parse(response.body)
      expect(updated_todo['name']).to eq('Updated Todo')
      expect(updated_todo['done']).to be_truthy
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a todo for the user' do
      todo = user.todos.create(name: 'Todo to Delete', done: false)
      delete :destroy, params: { user_id: user.id, id: todo.id }
      expect(response).to have_http_status(:no_content)
      expect { Todo.find(todo.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
