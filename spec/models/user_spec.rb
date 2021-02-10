require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'simple user' do
    let(:user) { create(:user) }

    context 'should' do
      it 'have user role by default after create' do
        expect(user.roles).to eq(['user'])
      end

      it 'have user role by default after create' do
        expect(user.profile).not_to be nil
      end
    end
  end

  describe 'stubbed user' do
    let(:user) { build_stubbed(:user) }

    context 'should' do
      it 'have sport flag false by default' do
        expect(user.sport_flag).to be false
      end

      it 'have theme default' do
        expect(user.theme).to eq('default')
      end

      it 'have guest role by default for unreg user' do
        expect(user.roles).to eq(['guest'])
      end

      it 'have roles' do
        user.roles= []
        expect(user.valid?).to be false
        expect(user.errors[:roles]).not_to be_empty
      end

      it 'have theme inclusion list THEMES' do
        user.theme = 'sexy'
        expect(user.valid?).to be false
        expect(user.errors[:theme]).not_to be_empty
      end

      it 'have theme valid' do
        THEMES.each do |theme|
          user.theme = theme
          expect(user.valid?).to be true
          expect(user.errors[:theme]).to be_empty
        end
      end

      it 'have theme' do
        user.theme = nil
        expect(user.valid?).to be false
        expect(user.errors[:theme]).not_to be_empty
      end
    end
  end
end
