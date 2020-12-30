require 'rails_helper'

RSpec.describe "operations/edit", type: :view do
  before(:each) do
    @operation = assign(:operation, Operation.create!(
      title: "MyString"
    ))
  end

  it "renders the edit operation form" do
    render

    assert_select "form[action=?][method=?]", operation_path(@operation), "post" do

      assert_select "input[name=?]", "operation[title]"
    end
  end
end
