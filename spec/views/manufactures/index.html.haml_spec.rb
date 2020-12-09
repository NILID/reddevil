require 'rails_helper'

RSpec.describe "manufactures/index", type: :view do
  before(:each) do
    assign(:manufactures, [
      Manufacture.create!(
        :title => "Title",
        :drawing => "Drawing",
        :contract => "Contract",
        :material => "Material",
        :user => "User",
        :machine => "Machine",
        :operation => "MyText",
        :otk => "Otk",
        :priority => "Priority"
      ),
      Manufacture.create!(
        :title => "Title",
        :drawing => "Drawing",
        :contract => "Contract",
        :material => "Material",
        :user => "User",
        :machine => "Machine",
        :operation => "MyText",
        :otk => "Otk",
        :priority => "Priority"
      )
    ])
  end

  it "renders a list of manufactures" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Drawing".to_s, :count => 2
    assert_select "tr>td", :text => "Contract".to_s, :count => 2
    assert_select "tr>td", :text => "Material".to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
    assert_select "tr>td", :text => "Machine".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Otk".to_s, :count => 2
    assert_select "tr>td", :text => "Priority".to_s, :count => 2
  end
end
