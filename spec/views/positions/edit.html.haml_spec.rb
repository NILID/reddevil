require 'rails_helper'

RSpec.describe "positions/edit", type: :view do
  before(:each) do
    @member = create(:member)
    @departments = create_list(:department, 2)
    @position = assign(:position, create(:position, member: @member))
  end

  it "renders the edit position form" do
    render

    assert_select "form[action=?][method=?]", member_position_path(@member, @position), "post" do

      assert_select "input[name=?]", "position[position]"

      assert_select "select[name=?]", "position[department_id]"

      assert_select "input[name=?]", "position[moved_at]"
    end
  end
end
