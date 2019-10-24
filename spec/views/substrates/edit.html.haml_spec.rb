require 'rails_helper'

RSpec.describe "substrates/edit", type: :view do
  before(:each) do
    @substrate = assign(:substrate, create(:substrate))
  end

  it "renders the edit substrate form" do
    render

    assert_select "form[action=?][method=?]", substrate_path(@substrate), "post" do

      assert_select "input[name=?]", "substrate[drawing]"

      assert_select "input[name=?]", "substrate[detail]"

      assert_select "input[name=?]", "substrate[amount]"

      assert_select "input[name=?]", "substrate[contract]"

      assert_select "input[name=?]", "substrate[arrival_from]"

      assert_select "input[name=?]", "substrate[shipping_to]"

      assert_select "textarea[name=?]", "substrate[shipping_base]"

      assert_select "input[name=?]", "substrate[status]"
    end
  end
end
