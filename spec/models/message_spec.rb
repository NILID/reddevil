require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { build_stubbed(:message) }

  context 'should' do
    it 'have content' do
      message.content = nil
      expect(message.valid?).to be false
    end
  end
end
