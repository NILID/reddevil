require 'rails_helper'

RSpec.describe "positions/index", type: :view do
  before(:each) do
    assign(:positions, [
      Position.create!(
        :position => "Position",
        :department => nil,
        :member => nil
      ),
      Position.create!(
        :position => "Position",
        :department => nil,
        :member => nil
      )
    ])
  end

  it "renders a list of positions" do
    render
    assert_select "tr>td", :text => "Position".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
