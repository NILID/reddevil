require_relative 'controller_macros'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers,  type: :controller
  config.include Devise::Test::ControllerHelpers,  type: :view
  config.include Devise::Test::ControllerHelpers,  type: :feature
  config.include Devise::Test::ControllerHelpers,  type: :helper
  config.include Devise::Test::IntegrationHelpers, type: :request

  config.extend ControllerMacros, type: :controller
  config.extend ControllerMacros, type: :request
end