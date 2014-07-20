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
      silvers = params[:silver_team].split(',')
      blacks  = params[:black_team].split(',')

      unless silvers.any? || blacks.any?
        return render text: 'Must provide at least one silver team player and black team player', status: 400
      end

      game = Game.create unclaimed_signatures: { silver_team: silvers,
                                                 black_team:  blacks },
                         created_at: start_time

      Resque.push 'games', class: 'PlayerCalculatorJob', args: [game.id]
      return render json: {game_id: game.id}, status: :created
    end

    private

    def required_create_params
      %w[silver_team black_team timestamp]
    end

  end
end
