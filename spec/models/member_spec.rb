require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member) { build(:member) }

  context 'should' do
    it 'have user role by default after create' do
      expect(member.fullname).to eq("#{member.surname} #{member.name} #{member.patronymic}")
    end
  end
end
