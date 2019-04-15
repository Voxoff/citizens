require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#username' do
    it 'validates uniquness' do
      User.create!(username: 'some_user', password: '123123')
      user = User.new(username: 'some_user')
      user.valid?

      expect(user.errors[:username]).to include("has already been taken")
    end
  end
end
