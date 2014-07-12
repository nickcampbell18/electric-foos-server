module Api
  class GamesController < ApplicationController

    before_filter :has_required_params

    def create
      head :created
    end

    private

    def has_required_params
      required = %w[teams timestamp]
      unprovided = required - params.keys
      binding.pry
      failures = unprovided.each_with_object('') do |param, response|
        response << "'#{param}' parameter is required\n"
      end
      if failures.present?
        return render text: failures, status: :bad_request
      end
    end

  end
end
