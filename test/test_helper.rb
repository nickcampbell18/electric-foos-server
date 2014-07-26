ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'minitest/pride'

class ActiveSupport::TestCase
end

class ActionController::TestCase

  def login_with_api_token!
    request.headers['Authorization'] = 'Token token=%s' % ENV['API_TOKEN']
  end

  def res_json
    ActiveSupport::JSON.decode @response.body
  end

end
