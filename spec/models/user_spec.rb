require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { build(:user) }

  context 'should' do
    it 'have sport flag false by default' do
      expect(user.sport_flag).to be false
    end

    it 'have guest role by default for unreg user' do
      expect(user.roles.empty?).to be true
    end

    it 'have user role by default after create' do
      user.save!
      expect(user.roles).to eq(['user'])
    end
  end
end
