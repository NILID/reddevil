require 'rails_helper'

RSpec.describe "positions/index", type: :view do
  before(:each) do
    @member = create(:member)
    assign(:positions, create_list(:position, 2, member: @member))
  end

  it "renders a list of positions" do
    render
    assert_select "h2", :text => "Профессиональный путь #{@member.petrovich_surname_name}".to_s, :count => 1
  end
end
