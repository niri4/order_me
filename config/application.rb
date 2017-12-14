require_relative 'boot'

require "rails"

require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"

require "sprockets/railtie"

Bundler.require(*Rails.groups)

module OrderMe
  class Application < Rails::Application
    config.load_defaults 5.1
  end
end
