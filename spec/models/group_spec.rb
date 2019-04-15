require 'rails_helper'

RSpec.describe Group, type: :model do
  describe '#name' do
    it 'validates uniquness' do
      Group.create(name: 'some_group')
      group = Group.new(name: 'some_group')
      group.valid?

      expect(group.errors[:name]).to include("has already been taken")
    end
  end
end
