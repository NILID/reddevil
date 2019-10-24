require 'rails_helper'

RSpec.describe "substrates/show", type: :view do
  before(:each) do
    @substrate = assign(:substrate, create(:substrate))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Drawing/)
    expect(rendered).to match(/Detail/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Contract/)
    expect(rendered).to match(/Arrival From/)
    expect(rendered).to match(/Shipping To/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(//)
  end
end
