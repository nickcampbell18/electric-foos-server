module Api
  class GoalsController < ApplicationController

    before_filter :ensure_required_create_params

    def create
      unless game
        return render text: 'Game not found.'
      end
      unless params[:team].to_s.in? %w[silver black]
        return render text: 'Team must be "silver" or "black".'
      end
      Resque.push 'goals', class: 'GoalCreatorJob', args: [game.id, params[:team], timestamp]
      head :created
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
