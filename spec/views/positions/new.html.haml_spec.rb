require 'rails_helper'

RSpec.describe "positions/new", type: :view do
  before(:each) do
    @member = create(:member)
    @departments = create_list(:department, 2)
    assign(:position, build(:position, member: @member))
  end

  it "renders new position form" do
    render

    assert_select "form[action=?][method=?]", member_positions_path(@member), "post" do

      assert_select "input[name=?]", "position[position]"

      assert_select "select[name=?]", "position[department_id]"

      assert_select "input[name=?]", "position[moved_at]"
    end
  end
end
