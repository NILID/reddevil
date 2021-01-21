require 'rails_helper'

RSpec.describe "manufactures/new", type: :view do
  before(:each) do
    create_list(:user, 2, :from_lab181)
    @manufacture = assign(:manufacture, build(:manufacture))
  end

  it "renders new manufacture form" do
    render

    assert_select "form[action=?][method=?]", manufactures_path, "post" do

      assert_select "input[name=?]", "manufacture[title]"

      assert_select "input[name=?]", "manufacture[drawing]"

      assert_select "select[name=?]", "manufacture[material]"

      assert_select "input[name=?]", "manufacture[user]"

      assert_select "input[name=?]", "manufacture[machine]"

      assert_select "select[name=?]", "manufacture[priority]"
    end
  end
end
