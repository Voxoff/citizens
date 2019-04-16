require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  let(:invalid_headers) do
     { Authorization: 'Bearer 56788765' }
  end

  describe '#create' do
    it 'allows an admin to create a group' do
      user = User.create(username: 'Guy', password: '123123', admin: true)
      #OR JWT.encode(payload, ENV['SECRET'])
      token = ApplicationController.new.encode_token(user_id: user.id)
      request.headers[:Authorization] = "Bearer #{token}" })

      post :create
      expect(response).to have_http_status(:created)
    end


    it 'rejects request if user is not an admin' do
      user = User.create(username: 'Guy', password: '123123')
      token = ApplicationController.new.encode_token(user_id: user.id)
      request.headers[:Authorization] = "Bearer #{token}" })

      post :create
      expect(response).to have_http_status(:unauthorized)
    end

    it 'rejects request if headers are incorrect' do
      request.headers.merge!(invalid_headers)
      post :create
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
