require 'rails_helper'

RSpec.describe "manufactures/show", type: :view do
  before(:each) do
    @manufacture = assign(:manufacture, create(:manufacture))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MyTitle/)
    expect(rendered).to match(/MyDrawing/)
    expect(rendered).to match(/MyContract/)
    expect(rendered).to match(/кварц/)
    # expect(rendered).to match(/User/)
    expect(rendered).to match(/MyMachine/)
    expect(rendered).to match(/MyOperation/)
    expect(rendered).to match(/4/)
  end
end
