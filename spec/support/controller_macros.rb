require 'cancan/matchers'

module ControllerMacros

  def login_user(role=:user)
    before(:each) do
      #@request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = (role == :user) ? create(:user) : create(:user, role)
      sign_in(@user)
      @ability = Ability.new(@user)
    end
  end

end