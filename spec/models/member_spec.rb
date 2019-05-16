require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member) { build(:member) }

  context 'should' do
    it 'have fullname' do
      expect(member.valid?).to be true
    end

    it 'have fullname' do
      expect(member.fullname).to eq("#{member.surname} #{member.name} #{member.patronymic}")
    end

    it 'have name' do
      member.name = nil
      expect(member.valid?).to be false
    end

    it 'have surname' do
      member.surname = nil
      expect(member.valid?).to be false
    end

    it 'have patronymic' do
      member.patronymic = nil
      expect(member.valid?).to be false
    end
 end
end
