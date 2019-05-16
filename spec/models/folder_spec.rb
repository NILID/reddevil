require 'rails_helper'

RSpec.describe Folder, type: :model do
  let(:folder) { create(:folder) }

  context 'should' do
    it 'have title' do
      folder.title = nil
      expect(folder.valid?).to be false
    end
  end
end
