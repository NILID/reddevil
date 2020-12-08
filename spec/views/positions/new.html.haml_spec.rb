require 'rails_helper'

RSpec.describe "positions/new", type: :view do
  before(:each) do
    assign(:position, Position.new(
      :position => "MyString",
      :department => nil,
      :member => nil
    ))
  end

  it "renders new position form" do
    render

    assert_select "form[action=?][method=?]", positions_path, "post" do

      assert_select "input[name=?]", "position[position]"

      assert_select "input[name=?]", "position[department_id]"

      assert_select "input[name=?]", "position[member_id]"
    end
  end
end
