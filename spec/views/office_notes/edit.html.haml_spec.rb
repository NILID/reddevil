require 'rails_helper'

RSpec.describe "office_notes/edit", type: :view do
  before(:each) do
    @office_note = assign(:office_note, OfficeNote.create!(
      :num => "MyString",
      :title => "MyString",
      :whom => "MyString"
    ))
  end

  it "renders the edit office_note form" do
    render

    assert_select "form[action=?][method=?]", office_note_path(@office_note), "post" do

      assert_select "input[name=?]", "office_note[num]"

      assert_select "input[name=?]", "office_note[title]"

      assert_select "input[name=?]", "office_note[whom]"
    end
  end
end
