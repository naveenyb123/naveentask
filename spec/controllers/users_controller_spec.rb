require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_user_params) do
    { user: { name: 'John Doe', email: 'john@example.com', password: 'password123' } }
  end

  let(:invalid_user_params) do
    { user: { name: 'John Doe', email: 'invalid_email', password: 'password123' } }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it "creates a new user" do
        expect {
          post :create, params: valid_user_params
        }.to change(User, :count).by(1)
      end

      it 'returns a status code of 201 (Created)' do
        post :create, params: valid_user_params
        expect(response).to have_http_status(:created)
      end

      it 'returns the created user in JSON' do
        post :create, params: valid_user_params
        user = JSON.parse(response.body)
        expect(user['name']).to eq('John Doe')
        expect(user['email']).to eq('john@example.com')
        # Add more expectations for other user attributes as needed
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: invalid_user_params
        }.not_to change(User, :count)
      end

      it 'returns a status code of 422 (Unprocessable Entity)' do
        post :create, params: invalid_user_params
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns errors for invalid user data in JSON' do
        post :create, params: invalid_user_params
        user_errors = JSON.parse(response.body)
        expect(user_errors).to have_key('email')
        # Add more error expectations as needed
      end
    end
  end

  describe 'GET #show' do
  let(:user) { create(:user) } # This will create a user using the factory

  it 'returns a specific user in JSON' do
    get :show, params: { id: user.id }
    expect(response).to have_http_status(:ok)
    user_response = JSON.parse(response.body)
    expect(user_response['name']).to eq(user.name)
    expect(user_response['email']).to eq(user.email)
    # Add more expectations for other user attributes as needed
  end
end
end
