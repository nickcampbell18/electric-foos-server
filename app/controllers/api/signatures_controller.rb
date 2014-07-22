module Api
  class SignaturesController < ApplicationController

    def show
      opts = {team: params.fetch(:team, 'unknown')}
      if player = Player.find_by_signature(params[:id])
        Pusher['registration'].trigger 'player_found', player.as_push.merge(opts)
      end
      head :ok
    end

  end
end
