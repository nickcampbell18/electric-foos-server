module Api
  class GoalsController < ApplicationController

    before_filter :ensure_required_create_params

    def create
      head :created
    end

    private

    def required_create_params
      %w[game_id team timestamp]
    end

  end
end
