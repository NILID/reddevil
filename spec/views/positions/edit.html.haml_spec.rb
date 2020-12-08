require 'rails_helper'

RSpec.describe "positions/edit", type: :view do
  before(:each) do
    @position = assign(:position, Position.create!(
      :position => "MyString",
      :department => nil,
      :member => nil
    ))
  end

  it "renders the edit position form" do
    render

    assert_select "form[action=?][method=?]", position_path(@position), "post" do

      assert_select "input[name=?]", "position[position]"

      assert_select "input[name=?]", "position[department_id]"

      assert_select "input[name=?]", "position[member_id]"
    end
  end
end
