require 'test_helper'

class MachineTest < ActiveSupport::TestCase
  def setup
    @machine = machines(:one)
  end

  test 'machine must have title' do
    @machine.title = ''
    assert !@machine.valid?
    assert_not_empty @machine.errors[:title]
  end
end
