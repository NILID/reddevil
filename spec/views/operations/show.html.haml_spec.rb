require 'rails_helper'

RSpec.describe "operations/show", type: :view do
  before(:each) do
    @operation = assign(:operation, Operation.create!(
      title: "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
