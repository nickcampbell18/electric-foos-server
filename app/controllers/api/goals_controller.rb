module Api
  class GoalsController < ApplicationController

    before_filter :ensure_required_create_params

    def create
      unless game
        return render json: {errors: ['Game not found.']}
      end
      unless params[:team].to_s.in? %w[silver black]
        return render json: {errors: ['Team must be "silver" or "black"']}
      end

      team = Team.find_by_game_and_colour(game, params[:team])

      Goal.create team: team, created_at: timestamp

      respond_with :api, game, status: :created
    end

    private

    def game
      Game.find params[:game_id]
    end

    def timestamp
      Time.parse params[:timestamp]
    end

    def required_create_params
      %w[game_id team timestamp]
    end

  end
end
