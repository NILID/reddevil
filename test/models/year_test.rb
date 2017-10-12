require 'test_helper'

class YearTest < ActiveSupport::TestCase

  def setup
    @year = years(:one)
  end

  test 'year must have year' do
    @year.year = ''
    assert !@year.valid?
    assert_not_empty @year.errors[:year]
  end
end
