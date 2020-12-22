require 'rails_helper'

RSpec.describe "manufactures/edit", type: :view do

  before(:each) do
    create_list(:user, 2, :from_lab181)
    @manufacture = assign(:manufacture, create(:manufacture))
  end

  it "renders the edit manufacture form" do
    render

    assert_select "form[action=?][method=?]", manufacture_path(@manufacture), "post" do

      assert_select "input[name=?]", "manufacture[title]"

      assert_select "input[name=?]", "manufacture[drawing]"

      assert_select "input[name=?]", "manufacture[contract]"

      assert_select "select[name=?]", "manufacture[material]"

      assert_select "input[name=?]", "manufacture[user]"

      assert_select "input[name=?]", "manufacture[machine]"

      assert_select "input[name=?]", "manufacture[operation]"

      assert_select "select[name=?]", "manufacture[priority]"
    end
  end
end
