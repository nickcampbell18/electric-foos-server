class MetricsGenerator

  def self.perform
    player_metrics
    team_metrics
  end

  def self.player_metrics
    # Iterate through all teams, and find their scores
    metrics = Team.all.each_with_object({}) do |team, result|
      # Hash key is players.sort.join('-')
      team.players.compact.each do |player|
        result[player.id] ||= 0
        result[player.id] += team.score
      end
    end

    keys_and_values = Array(metrics).flatten

    db.call [:del, Metrics::PLAYER]
    db.call [:hmset, Metrics::PLAYER, *keys_and_values]
  end

  def self.team_metrics
    metrics = Team.all.each_with_object({}) do |team, result|
      players = [team.player_one_id, team.player_two_id].compact

      next if players.size < 2
      players = players.sort.join ':'
      result[players] ||= 0
      result[players] += team.score
    end

    db.call [:del, Metrics::TEAM]
    return if metrics.empty?

    keys_and_values = Array(metrics).flatten
    db.call [:hmset, Metrics::TEAM, *keys_and_values]
  end

  def self.db
    Redis::Client.new
  end

end
