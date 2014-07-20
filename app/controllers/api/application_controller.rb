module Api
  class ApplicationController < ::ApplicationController

    before_action :authenticate

    def authenticate
      authenticate_or_request_with_http_token do |token|
        token == ENV.fetch('API_TOKEN')
      end
    end

  end
end
