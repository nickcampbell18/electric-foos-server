module Api
  class PlayersController < ApplicationController

    def create
      unless params[:permalink] && params[:signature]
        return render text: 'Please provide a `permalink` and `signature` parameter', status: 400
      end

      player = Player.find_by_signature(params[:signature]) or
        Player.create(permalink:  params[:permalink],
                      signatures: [params[:signature]])

      Resque.push 'players', class: 'YammerUpdaterJob',
                             args: [player.id]
      head :ok
    end

  end
end
