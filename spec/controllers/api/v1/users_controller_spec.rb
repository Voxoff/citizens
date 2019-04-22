require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe '#create' do
    let(:valid_params) do
      {
        user: {
          username: 'Guy',
          password: '123123'
        }
      }
    end

    it 'creates a user with valid params' do
      post :create, params: valid_params
      expect(response).to have_http_status(:created)
      expect(json.keys).to match_array(%w[jwt user])
    end

    it 'renders a message with invalid params' do
      post :create, params: { user: { username: '', password: '' } }
      expect(response).to have_http_status(:not_acceptable)
      expect(json).to have_key('error')
    end
  end

  describe '#profile' do
    let(:user) { User.create(username: 'user', password: '123123', email: 'email@email.com') }

    before(:each) do
      make_token_header(user)
    end

    it 'returns not found if username is not found' do
      post :profile, params: make_params(username: 'username')
      expect(response).to have_http_status(:not_found)
      expect(json['message']).to eq('The user could not be found')
    end

    it 'returns not found if email is not found' do
      post :profile, params: make_params(email: 'email')
      expect(response).to have_http_status(:not_found)
      expect(json['message']).to eq('The user could not be found')
    end

    it 'returns not found if no information is provided' do
      post :profile, params: make_params
      expect(response).to have_http_status(:not_found)
      expect(json['message']).to eq('The user could not be found')
    end

    it 'returns user if correct username provided' do
      post :profile, params: make_params(username: 'user')
      expect(response).to have_http_status(:accepted)
      expect(json).to have_key('user')
    end

    it 'returns user if correct email provided' do
      post :profile, params: make_params(email: user.email)
      expect(response).to have_http_status(:accepted)
      expect(json).to have_key('user')
    end
  end

  def make_params(attr = {})
    username = attr[:username]
    email = attr[:email]
    { user: { email: email, username: username } }
  end
end
