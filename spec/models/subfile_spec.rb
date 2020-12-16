require 'rails_helper'

RSpec.describe Subfile, type: :model do
  let(:subfile) { build_stubbed(:subfile) }

  context 'should' do
    it 'have src' do
      subfile.src = nil
      expect(subfile.valid?).to be false
      expect(subfile.errors[:src]).not_to be_empty
    end
  end
end
