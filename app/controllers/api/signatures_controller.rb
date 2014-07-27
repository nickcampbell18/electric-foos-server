module Api
  class SignaturesController < ApplicationController

    before_filter :ensure_required_create_params

    def create
      if player = Player.find_by_signature(params[:rfid])
        @player = player
      else
        @player = Player.create signatures: [params[:rfid]]
      end
      Publisher.publish @player
      return render json: @player.as_json
    end

    private

    def required_create_params
      %w[team rfid]
    end

  end
end
