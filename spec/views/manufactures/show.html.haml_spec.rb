require 'rails_helper'

RSpec.describe "manufactures/show", type: :view do
  before(:each) do
    assign(:manufacture, create(:manufacture_with_operations))
    @operations = create_list(:manufacture_operation, 2)
    @otk_documents = []
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyTitle/)
    expect(rendered).to match(/MyDrawing/)
    expect(rendered).to match(/кварц/)
    # expect(rendered).to match(/User/)
    expect(rendered).to match(/4/)
  end
end
