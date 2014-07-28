module Api
  class GamesController < ApplicationController

    respond_to :json

    before_filter :ensure_required_create_params, only: :create

    def show
      @game = Game.find params[:id]
      respond_with @game
    end

    def create
      start_time = Time.parse params[:timestamp]
      silvers = coerce_array params[:silver_team]
      blacks  = coerce_array params[:black_team]

      unless silvers.any? && blacks.any?
        return render json: {
          errors:'Must provide at least one silver team player and black team player'
        }, status: 400
      end

      @game = Game.create unclaimed_signatures: { silver_team: silvers,
                                                 black_team:  blacks },
                          created_at: start_time

      Resque.push 'games', class: 'PlayerCalculatorJob', args: [@game.id]
      respond_with :api, @game, status: :created
    end

    def update
      game = Game.find params[:id]
      params[:teams].map do |obj|
        team = Team.find obj[:id]

        if team.score != obj[:score]
          team.score = obj[:score]
        end
      end
      Publisher.publish game
      respond_with game
    end

    private

    def required_create_params
      %w[silver_team black_team timestamp]
    end

  end
end
