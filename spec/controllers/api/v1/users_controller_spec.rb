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

    it 'should create a user with valid params' do
      post :create, params: valid_params
      expect(response).to have_http_status(:created)
      expect(json.keys).to match_array(%w[jwt user])
    end

    it 'should render a message with invalid params' do
      post :create, params: { user: { username: '', password: '' } }
      expect(response).to have_http_status(:not_acceptable)
      expect(json).to have_key('error')
    end
  end
end
