require 'test_helper'

class TempuserTest < ActiveSupport::TestCase

  def setup
    @tempuser = tempusers(:one)
  end

  test 'tempuser must have username' do
    @tempuser.username = ''
    assert !@tempuser.valid?
    assert_not_empty @tempuser.errors[:username]
  end
end
