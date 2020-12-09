require 'rails_helper'

RSpec.describe "manufactures/edit", type: :view do
  before(:each) do
    @manufacture = assign(:manufacture, Manufacture.create!(
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

  it "renders the edit manufacture form" do
    render

    assert_select "form[action=?][method=?]", manufacture_path(@manufacture), "post" do

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
