require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:user) { build(:user) }

  context 'should' do
    it 'have sport flag false by default' do
      expect(user.sport_flag).to be false
    end

    it 'have guest role by default for unreg user' do
      expect(user.roles).to eq(['guest'])
    end

    it 'have roles' do
      user.roles= []
      expect(user.valid?).to be false
      expect(user.errors[:roles]).not_to be_empty
    end

    it 'have user role by default after create' do
      user.save!
      expect(user.roles).to eq(['user'])
    end

    it 'have user role by default after create' do
      user.save!
      expect(user.profile).not_to be nil
    end
  end
end
