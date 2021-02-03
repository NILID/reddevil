require 'rails_helper'

RSpec.describe "manufactures/index", type: :view do
  before(:each) do
    assign(:manufactures, create_list(:manufacture, 2))
    @q = Manufacture.ransack(params[:q])
  end

  it "renders a list of manufactures" do
    render
    assert_select "tr>td", :text => "MyTitle".to_s, :count => 2
    assert_select "tr>td", :text => "MyDrawing".to_s, :count => 2
    assert_select "tr>td", :text => "MyContract".to_s, :count => 2
    assert_select "tr>td", :text => "кварц".to_s, :count => 2
    # assert_select "tr>td", :text => "MyUser".to_s, :count => 2
    assert_select "tr>td", :text => "MyOperation".to_s, :count => 2
    # assert_select "tr>td", :text => "OTK".to_s, :count => 2
    assert_select "tr>td", :text => "4".to_s, :count => 2
  end
end
