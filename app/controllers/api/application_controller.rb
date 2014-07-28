require 'json'
require 'redis'

module Api
  class ApplicationController < ::ApplicationController

    before_action :authenticate

    rescue_from ActiveRecord::RecordNotFound, :with => :not_found

    def authenticate
      authenticate_or_request_with_http_token do |token|
        token == ENV.fetch('API_TOKEN')
      end
    end

    def not_found
      return render status: 404, json: {error: 'Could not find that, sorry.'}
    end

    def publish(object)
      Publisher.publish(object)
    end

  end
end
