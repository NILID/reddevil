require 'rails_helper'

RSpec.describe "office_notes/new", type: :view do
  before(:each) do
    assign(:office_note, OfficeNote.new(
      :num => "MyString",
      :title => "MyString",
      :whom => "MyString"
    ))
  end

  it "renders new office_note form" do
    render

    assert_select "form[action=?][method=?]", office_notes_path, "post" do

      assert_select "input[name=?]", "office_note[num]"

      assert_select "input[name=?]", "office_note[title]"

      assert_select "input[name=?]", "office_note[whom]"
    end
  end
end
