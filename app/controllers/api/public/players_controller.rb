module Api
  module Public
    class PlayersController < PublicController

      def index
        render json: Player.all_complete
      end

      def show
        render json: Player.find(params[:id])
      end

    end
  end
end
