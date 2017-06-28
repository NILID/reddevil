require 'test_helper'

class RoundTest < ActiveSupport::TestCase

  def setup
    @round = rounds(:one)
  end

  test 'round must have title' do
    @round.title = ''
    assert !@round.valid?
    assert_not_empty @round.errors[:title]
  end
end
