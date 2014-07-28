module Api
  class GoalsController < ApplicationController

    respond_to :json

    before_filter :ensure_required_create_params,
                  :require_game

    def create
      unless params[:team].to_s.in? %w[silver black]
        return render json: {errors: ['Team must be "silver" or "black"']}
      end

      team = Team.find_by_game_and_colour(game, params[:team])

      Goal.create team: team, created_at: timestamp
      Score.new(team.id).increment

      respond_with :api, game
    end

    def cancel
      team = Team.find_by_game_and_colour(game, params[:team])

      if team
        goal = team.goals.order('created_at DESC').first
        if goal
          goal.destroy
          Score.new(team.id).decrement
        end
      end

      respond_with :api, game
    end

    private

    def require_game
      unless game
        return render json: {errors: ['Game not found.']}
      end
    end


    def game
      @_g ||= Game.find params[:game_id]
    end

    def timestamp
      Time.parse params[:timestamp]
    end

    def required_create_params
      %w[game_id team timestamp]
    end

  end
end
