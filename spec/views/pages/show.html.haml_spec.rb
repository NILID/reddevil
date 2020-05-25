require 'rails_helper'

RSpec.describe "pages/show", type: :view do
  before(:each) do
    @page = assign(:page, create(:page))
  end

  it "renders attributes in <p>" do
    render
    # expect(rendered).to match(/Title/)
    # expect(rendered).to match(/MyText/)
    # expect(rendered).to match(/Slug/)
    # expect(rendered).to match(//)
  end
end
