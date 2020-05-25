require 'rails_helper'

RSpec.describe "office_notes/show", type: :view do
  before(:each) do
    @office_note = assign(:office_note, create(:office_note))
  end

  it "renders attributes in <p>" do
    render
    # expect(rendered).to match(/Num/)
    # expect(rendered).to match(/Title/)
    # expect(rendered).to match(/Whom/)
  end
end
