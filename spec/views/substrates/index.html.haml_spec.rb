require 'rails_helper'

RSpec.describe "substrates/index", type: :view do
  before(:each) do
    assign(:substrates, create_list(:substrate, 2))
  end

  it "renders a list of substrates" do
    render
    assert_select "tr>td", :text => "MyDrawing".to_s, :count => 2
    assert_select "tr>td", :text => "MyDetail".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyContract".to_s, :count => 2
    assert_select "tr>td", :text => "MyArrival From".to_s, :count => 2
    assert_select "tr>td", :text => "MyShipping To".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyStatus".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
