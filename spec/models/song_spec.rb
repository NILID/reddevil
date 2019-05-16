require 'rails_helper'

RSpec.describe Song, type: :model do
  let(:song) { build(:song) }

  context 'should' do
    it 'have file' do
      song.file = nil
      expect(song.valid?).to be false
    end
  end
end
