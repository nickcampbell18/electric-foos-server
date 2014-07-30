module Api
  module Public
    class GamesController < PublicController

      def index
        render json: Game.with_includes_and_sorted.all
      end

      def show
        render json: Game.with_includes_and_sorted.find(params[:id])
      end

      def current
        render json: Game.current
      end

    end
  end
end
