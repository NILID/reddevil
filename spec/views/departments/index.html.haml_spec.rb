require 'rails_helper'

RSpec.describe "departments/index", type: :view do
  before(:each) do
    assign(:departments, create_list(:department, 2))
  end

  it "renders a list of departments" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
