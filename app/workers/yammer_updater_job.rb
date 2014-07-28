class YammerUpdaterJob

  MUGSHOT_SIZE = '256'

  def self.perform(player_id)
    player = Player.find player_id

    return unless player.permalink?

    email = [player.permalink, 'yammer-inc.com'].join('@')

    response = Yammer.get_user_by_email(email)

    if response.code.to_s =~ /404/
      email = [player.permalink, 'microsoft.com'].join('@')
      response = Yammer.get_user_by_email(email)
    end

    if response && response.body && response.body[0]
      body = response.body[0]
      player.update_attributes mugshot: fix_mugshot(body[:mugshot_url_template]),
                               name:    body[:full_name]
      player.save
    end

    Publisher.publish(player.as_json)
  end

  private

  def fix_mugshot(url_template)
    url_template.gsub /\{(width|height)\}/, MUGSHOT_SIZE
  end

end
