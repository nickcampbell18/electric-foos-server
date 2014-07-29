require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "rails/test_unit/railtie"

require_relative '../lib/active_record_ext'
require_relative '../lib/cors'

Bundler.require(*Rails.groups)

module Electric
  class Application < Rails::Application

    config.autoload_paths += %W(#{config.root}/lib)

    config.cache_store = :redis_store

    config.middleware.use 'Cors'

  end
end
