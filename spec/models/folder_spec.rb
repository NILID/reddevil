require 'rails_helper'

RSpec.describe Folder, type: :model do
  let(:folder) { build_stubbed(:folder) }

  context 'should' do
    it 'have title' do
      folder.title = nil
      expect(folder.valid?).to be false
    end
  end
end
