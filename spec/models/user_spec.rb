require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    let(:valid_params) do
      {
        username: 'username',
        password: 'password',
        email: 'email@example.com'
      }
    end

    describe '#username' do
      it 'validates uniqueness' do
        User.create(valid_params)
        user = User.new(username: 'username', password: '123')
        user.valid?

        expect(user.errors[:username]).to include('has already been taken')
      end
    end

    describe '#email' do
      it 'validates email format' do
        user = User.create(valid_params.merge(email: 'invalid_email'))
        expect(user).to be_invalid
      end
    end
  end
end
