require 'rails_helper'

RSpec.describe Album, type: :model do
  let(:album) { build(:album) }

  context 'should' do
    it 'have title' do
      album.title = nil
      expect(album.valid?).to be false
    end
  end
end
