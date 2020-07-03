require 'rails_helper'

RSpec.describe Department, type: :model do

  let(:department) { build_stubbed(:department) }

  context 'should' do
    it 'have title' do
      department.title = nil
      expect(department.valid?).to be false
    end
  end
end
