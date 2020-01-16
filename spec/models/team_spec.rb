require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { build_stubbed(:team) }

  context 'should' do
    it 'have title' do
      team.title = nil
      expect(team.valid?).to be false
    end
  end
end
