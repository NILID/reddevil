require 'rails_helper'

RSpec.describe "manufactures/new", type: :view do
  before(:each) do
    assign(:manufacture, Manufacture.new(
      :title => "MyString",
      :drawing => "MyString",
      :contract => "MyString",
      :material => "MyString",
      :user => "MyString",
      :machine => "MyString",
      :operation => "MyText",
      :otk => "MyString",
      :priority => "MyString"
    ))
  end

  it "renders new manufacture form" do
    render

    assert_select "form[action=?][method=?]", manufactures_path, "post" do

      assert_select "input[name=?]", "manufacture[title]"

      assert_select "input[name=?]", "manufacture[drawing]"

      assert_select "input[name=?]", "manufacture[contract]"

      assert_select "input[name=?]", "manufacture[material]"

      assert_select "input[name=?]", "manufacture[user]"

      assert_select "input[name=?]", "manufacture[machine]"

      assert_select "textarea[name=?]", "manufacture[operation]"

      assert_select "input[name=?]", "manufacture[otk]"

      assert_select "input[name=?]", "manufacture[priority]"
    end
  end
end
