require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member) { build_stubbed(:member) }

  before(:each) do
    Faker::UniqueGenerator.clear
  end

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
      expect(member.errors[:name]).not_to be_empty
    end

    it 'have surname' do
      member.surname = nil
      expect(member.valid?).to be false
      expect(member.errors[:surname]).not_to be_empty
    end

    it 'have patronymic' do
      member.patronymic = nil
      expect(member.valid?).to be false
      expect(member.errors[:patronymic]).not_to be_empty
    end

    it 'be more 16 year' do
      member.birth = "19.09.#{Date.today.year - 15}"
      expect(member.valid?).to be false
      expect(member.errors[:birth]).not_to be_empty
    end

    it 'be skip validate 16 year if hide_year' do
      member.birth = "19.09.#{Date.today.year - 15}"
      member.hide_year = true
      expect(member.valid?).to be true
      expect(member.errors[:birth]).to be_empty
    end
  end
end
