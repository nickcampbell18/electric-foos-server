class Metrics

  KEY = 'metrics'

  def goals_by_player_id(player_id)
    all_goals[player_id] || 0
  end

  def all_goals
    @_a ||= Hash[*client.call([:hgetall, KEY])]
  end

  private

  def client
    Redis::Client.new
  end

end
