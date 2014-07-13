module Api
  class GamesController < ApplicationController

    before_filter :ensure_required_create_params

    def create
      head :created
    end

    private

    def required_create_params
      %w[silver_team black_team timestamp]
    end

  end
end
