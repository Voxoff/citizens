require 'rails_helper'

RSpec.describe Group, type: :model do
  describe '#name' do
    it 'validates uniquness' do
      group = Group.create(name: 'some_group')
      group_2 = Group.new(name: 'some_group')
      group_2.valid?

      expect(group_2.errors[:name]).to include("has already been taken")
    end
  end
end
