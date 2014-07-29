module Api
  module Public
    class GamesController < PublicController

      def index
        render json: Game.includes(teams: %i[player_one player_two]).all
      end

      def show
        render json: Game.includes(teams: %i[player_one player_two]).find(params[:id])
      end

      def current
        render json: Game.current
      end

    end
  end
end
