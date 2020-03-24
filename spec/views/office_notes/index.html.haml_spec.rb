require 'rails_helper'

RSpec.describe "office_notes/index", type: :view do
  before(:each) do
    assign(:office_notes, [
      OfficeNote.create!(
        :num => "Num",
        :title => "Title",
        :whom => "Whom"
      ),
      OfficeNote.create!(
        :num => "Num",
        :title => "Title",
        :whom => "Whom"
      )
    ])
  end

  it "renders a list of office_notes" do
    render
    assert_select "tr>td", :text => "Num".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Whom".to_s, :count => 2
  end
end
