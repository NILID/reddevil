require 'rails_helper'

RSpec.describe OfficeNote, type: :model do
  let(:office_note) { build_stubbed(:office_note) }

  context 'should' do
    it 'have title' do
      office_note.title = nil
      expect(office_note.valid?).to be false
      expect(office_note.errors[:title]).not_to be_empty
    end

    it 'have num' do
      office_note.num = nil
      expect(office_note.valid?).to be false
      expect(office_note.errors[:num]).not_to be_empty
    end

    it 'have format of num' do
      ['180/05-7', '190/05-01', 'ssdfs'].each do |str|
        office_note.num = str
        expect(office_note.valid?).to be false
        expect(office_note.errors[:num]).not_to be_empty
      end
    end

    it 'have valid format of num' do
      ['180/05-07', '180/05-1123123'].each do |str|
        office_note.num = str
        expect(office_note.valid?).to be true
        expect(office_note.errors[:num]).to be_empty
      end
    end

    it 'have whom' do
      office_note.whom = nil
      expect(office_note.valid?).to be false
      expect(office_note.errors[:whom]).not_to be_empty
    end
  end

  describe 'simple user' do
    let(:note) { create(:office_note) }

    context 'should' do
      it 'have uniq num' do
        new_note = build(:office_note)
        new_note.num = note.num
        expect(new_note.valid?).to be false
        expect(new_note.errors[:num]).not_to be_empty
      end

      it 'have not uniq num if next year' do
        new_note = OfficeNote.new(title: 'check', whom: 'Dmitry')
        new_note.num = note.num
        new_note.created_at = Date.today + 2.years
        expect(new_note.valid?).to be true
        expect(new_note.errors[:num]).to be_empty
      end

      it 'have next num' do
        new_note = OfficeNote.new
        expect(new_note.num).to eq('180/05-02')
      end
    end
  end
end
