require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @valid_user = users(:da)
  end

  test "user must have role and it will be 'user' by default" do
    @ivan = User.new({
      :email => 'ivan@petrov.me',
      :password => '12345678',
      :password_confirmation => '12345678'
    })
    assert @ivan.valid?
    @ivan.save!
    assert @ivan.role? :user
  end

end
