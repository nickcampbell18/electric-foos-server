module Api
  class GamesController < ApplicationController

    before_filter :ensure_required_create_params

    def create
      start_time = Time.parse params[:timestamp]
      silvers = params[:silver_team].split(',')
      blacks  = params[:black_team].split(',')

      unless silvers.any? || blacks.any?
        return render text: 'Must provide at least one silver team player and black team player', status: 400
      end

      game = Game.create

      Resque.push 'games', class: 'GameCreatorJob', args: [game.id, silvers, blacks, start_time]
      return render json: {game_id: game.id}, status: :created
    end

    private

    def required_create_params
      %w[silver_team black_team timestamp]
    end

  end
end
