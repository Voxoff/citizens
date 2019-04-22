require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  describe '#create' do
    let(:valid_params) do {
        user: {
          username: 'Guy',
          password: '123123'
        }
      }
    end
    let(:invalid_params) do {
        user: {
          username: 'Guy',
          password: 'password'
        }
      }
    end

    it 'authenticates a user with valid params' do
      User.create(valid_params[:user])
      post :create, params: valid_params
      expect(response).to have_http_status(:accepted)
      expect(json.keys).to match_array(%w[jwt user])
    end

    it 'renders a message with invalid params' do
      post :create, params: { user: { username: '', password: '' } }
      expect(response).to have_http_status(:unauthorized)
      expect(json).to have_key('message')
    end

    it 'renders a message if password is incorrect' do
      post :create, params: invalid_params
      expect(response).to have_http_status(:unauthorized)
      expect(json).to have_key('message')
    end
  end
end
