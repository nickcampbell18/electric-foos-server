class PusherController < ApplicationController

  def receive
    payload['events'].each do |event|
      if event['name'] == 'find_user'

        if player = Player.find_by_signature(event['signature'])
          Pusher['registration'].trigger 'player_found', player.as_push
        end

      elsif event['name'] == 'create_user'

        player = Player.create! name: event['player_name'],
                                signatures: [event['signature']],
                                mugshot: event['mugshot']

        Pusher['registration'].trigger 'player_created', player.as_push

      end
    end
  end

  private

    def payload
      @_p ||= JSON.parse request.body
    end

end
