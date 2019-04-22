require 'rails_helper'

RSpec.describe Api::V1::GroupsController, type: :controller do
  let(:invalid_headers) do
    { Authorization: 'Bearer 56788765' }
  end

  let(:admin) { User.create(username: 'admin', password: '123123', admin: true) }
  let(:not_admin) { User.create(username: 'not_admin', password: '123123') }

  before :each do
    make_token_header(admin)
  end

  describe 'admin authorization' do
    it 'rejects request if user is not an admin' do
      make_token_header(not_admin)

      post :create
      expect(response).to have_http_status(:unauthorized)
    end

    it 'rejects request if headers are incorrect' do
      request.headers.merge!(invalid_headers)
      post :create
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe '#create' do
    it 'allows an admin to create a group' do
      post :create, params: { group: { name: 'test' } }
      expect(response).to have_http_status(:created)
      expect(json).to have_key('group')
    end

    it 'does not create group if invalid' do
      Group.create(name: 'test')
      post :create, params: { group: { name: 'test' } }

      expect(response).to have_http_status(:not_acceptable)
      expect(json['message']).to eq('The group was not created')
    end
  end

  describe '#add_users' do
    let(:group) { Group.create(name: 'test') }
    it 'returns not_found status if group is not found' do
      post :add_users, params: { group: {user_ids: ['1'] }, 'id' => 5 }
      expect(response).to have_http_status(:not_found)
      expect(json['message']).to eq('The group could not be found')
    end

    it 'rejects if user is not admin' do
      make_token_header(not_admin)

      post :add_users, params: { group: { user_ids: ['1'] }, 'id' => 5 }
      expect(response).to have_http_status(:unauthorized)
      expect(json['message']).to eq('Not authorized')
    end

    it 'allows an admin to add a user to a group' do
      post :add_users, params: { group: { user_ids: ['1'] }, 'id' => group.id }
      expect(response).to have_http_status(:ok)
      expect(json['group'].keys.first).to eq 'id'
    end

    it 'allows an admin to add multiple users' do
      user = User.create(username: 'two', password: '123123')
      user_ids = [admin.id, user.id]
      params = { group: { user_ids: user_ids }, 'id': group.id }

      post :add_users, params: params
      expect(response).to have_http_status(:ok)
      expect(json['user_ids']).to eq user_ids
    end
  end
end
