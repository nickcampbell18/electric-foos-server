class PusherController < ApplicationController

  def receive
    params['events'].each do |event|
      if event['name'] == 'find_user'

        if player = Player.find_by_signature(event['signature'])
          Pusher['registration'].trigger 'player_found', player.as_json
        end

      elsif event['name'] == 'create_user'

        player = Player.create! name: event['player_name'],
                                signatures: [event['signature']],
                                mugshot: event['mugshot']

        Pusher['registration'].trigger 'player_created', player.as_json

      end
    end
    head :ok
  end

end
