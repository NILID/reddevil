require 'rails_helper'

RSpec.describe "pages/new", type: :view do
  before(:each) do
    assign(:page, Page.new(
      :title => "MyString",
      :content => "MyText",
      :slug => "MyString",
      :user => nil
    ))
  end

  it "renders new page form" do
    render

    assert_select "form[action=?][method=?]", pages_path, "post" do

      assert_select "input[name=?]", "page[title]"

      assert_select "textarea[name=?]", "page[content]"

      assert_select "input[name=?]", "page[slug]"

      assert_select "input[name=?]", "page[user_id]"
    end
  end
end
