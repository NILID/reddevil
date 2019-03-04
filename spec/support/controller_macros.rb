require 'cancan/matchers'

module ControllerMacros

  def login_user(user)
    user = (user == :user) ? nil : user
    before(:each) do
      #@request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = create(:user, user)
      sign_in(@user)
      @ability = Ability.new(@user)
    end
  end

end