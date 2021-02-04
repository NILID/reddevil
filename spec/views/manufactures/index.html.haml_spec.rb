require 'rails_helper'

RSpec.describe 'manufactures/index', type: :view do
  before(:each) do
    assign(:manufactures, create_list(:manufacture, 2))
    @operations = create_list(:operation, 2)
    @groups = create_list(:manufacture_group, 2)
    @q = Manufacture.ransack(params[:q])
  end

  it 'renders a list of manufactures' do
    render
    assert_select '.manufactures>.card>.card-header .manufacture-group-title', :text => 'MyString'.to_s, :count => 2
    assert_select '.manufactures>.card>.card-header .manufacture-group-contract', :text => 'MyContract'.to_s, :count => 2
    assert_select '.manufactures>.card>.card-header .manufacture-group-limit-at', :text => '21 января 2021'.to_s, :count => 2
  end
end
