require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:note) { build(:note, :with_screenshot) }

  context 'should' do
    it 'have content' do
      note.content = nil
      expect(note.valid?).to be false
    end
  end
end
