require 'rails_helper'

RSpec.describe "departments/index", type: :view do
  before(:each) do
    assign(:departments, [
      Department.create!(
        :title => "Title"
      ),
      Department.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of departments" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
