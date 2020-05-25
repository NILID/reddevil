require 'rails_helper'

RSpec.describe "pages/index", type: :view do
  before(:each) do
    assign(:pages, create_list(:page, 2))
  end

  it "renders a list of pages" do
    render
    # assert_select "tr>td", :text => "Title".to_s, :count => 2
    # assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # assert_select "tr>td", :text => "Slug".to_s, :count => 2
    # assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
