require 'rails_helper'

RSpec.describe "departments/index", type: :view do
  before(:each) do
    @departments = assign(:departments, create_list(:department, 2))
  end

  it "renders a list of departments" do
    render
    @departments.each do |dep|
      assert_select "tr>td", :text => dep.title.to_s, :count => 1
    end
  end
end
