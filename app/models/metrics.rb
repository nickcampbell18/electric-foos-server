class Metrics

  PLAYER = 'metrics:player'
  TEAM   = 'metrics:team'


  def goals_by_player_id(player_id)
    all_goals[player_id] || 0
  end

  def top_players
    Hash[*client.call([:hgetall, PLAYER])]
  end

  def top_teams
    Hash[*client.call([:hgetall, TEAM])]
  end

  private

  def client
    Redis::Client.new
  end

end
