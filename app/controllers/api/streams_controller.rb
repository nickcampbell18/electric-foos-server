require 'sse'

module Api
  class StreamsController < ApplicationController
    include ActionController::Live

    def stream
      response.headers['Content-Type'] = 'text/event-stream'
      sse = SSE.new(response.stream)
      begin
        loop do
          sse.write({ :message => "a thing" })
          sleep 1
        end
      rescue IOError
      ensure
        sse.close
      end
    end
  end
end
