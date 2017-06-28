require 'test_helper'

class TeamTest < ActiveSupport::TestCase

  def setup
    @team = teams(:russia)
  end

  test 'team must have title' do
    @team.title = ''
    assert !@team.valid?
    assert_not_empty @team.errors[:title]
  end
end
