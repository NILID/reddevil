require 'rails_helper'

RSpec.describe "manufactures/new", type: :view do
  before(:each) do
    @manufacture = assign(:manufacture, build(:manufacture))
  end

  it "renders new manufacture form" do
    render

    assert_select "form[action=?][method=?]", manufactures_path, "post" do

      assert_select "input[name=?]", "manufacture[title]"

      assert_select "input[name=?]", "manufacture[drawing]"

      assert_select "input[name=?]", "manufacture[contract]"

      assert_select "select[name=?]", "manufacture[material]"

      assert_select "input[name=?]", "manufacture[user]"

      assert_select "input[name=?]", "manufacture[machine]"

      assert_select "input[name=?]", "manufacture[operation]"

      assert_select "input[name=?]", "manufacture[priority]"
    end
  end
end
