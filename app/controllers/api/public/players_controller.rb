module Api
  module Public
    class PlayersController < PublicController

      respond_to :json

      def show
        @player = Player.find(params[:id])
         render json: @player
      end

    end
  end
end
