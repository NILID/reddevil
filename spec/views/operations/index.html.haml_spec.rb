require 'rails_helper'

RSpec.describe "operations/index", type: :view do
  before(:each) do
    assign(:operations, [
      Operation.create!(
        title: "Title"
      ),
      Operation.create!(
        title: "Title"
      )
    ])
  end

  it "renders a list of operations" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
  end
end
