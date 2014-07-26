class YammerUpdaterJob

  def self.perform(player_id)
    player = Player.find player_id

    return unless player.permalink?

    email = [player.permalink, 'microsoft.com'].join('@')

    response = Yammer.get_user_by_email(email)

    if response && response.body && response.body[0]
      body = response.body[0]
      player.update_attributes mugshot: body[:mugshot_url],
                               name:    body[:full_name]
      player.save
    end
  end
end
