require 'rails_helper'

RSpec.describe "manufactures/show", type: :view do
  before(:each) do
    @manufacture = assign(:manufacture, Manufacture.create!(
      :title => "Title",
      :drawing => "Drawing",
      :contract => "Contract",
      :material => "Material",
      :user => "User",
      :machine => "Machine",
      :operation => "MyText",
      :otk => "Otk",
      :priority => "Priority"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Drawing/)
    expect(rendered).to match(/Contract/)
    expect(rendered).to match(/Material/)
    expect(rendered).to match(/User/)
    expect(rendered).to match(/Machine/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Otk/)
    expect(rendered).to match(/Priority/)
  end
end
