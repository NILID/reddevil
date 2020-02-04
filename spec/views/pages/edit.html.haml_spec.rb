require 'rails_helper'

RSpec.describe "pages/edit", type: :view do
  before(:each) do
    @page = assign(:page, Page.create!(
      :title => "MyString",
      :content => "MyText",
      :slug => "MyString",
      :user => nil
    ))
  end

  it "renders the edit page form" do
    render

    assert_select "form[action=?][method=?]", page_path(@page), "post" do

      assert_select "input[name=?]", "page[title]"

      assert_select "textarea[name=?]", "page[content]"

      assert_select "input[name=?]", "page[slug]"

      assert_select "input[name=?]", "page[user_id]"
    end
  end
end
