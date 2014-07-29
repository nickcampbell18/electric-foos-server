class MetricsGenerator

  def self.perform
    # Iterate through all teams, and find their scores
    metrics = Team.all.each_with_object({}) do |team, result|
      # Hash key is players.sort.join('-')
      team.players.compact.each do |player|
        result[player.id] ||= 0
        result[player.id] += team.score
      end
    end

    keys_and_values = Array(metrics).flatten

    db.call [:del, Metrics::KEY]
    db.call [:hmset, Metrics::KEY, *keys_and_values]
  end

  def self.db
    Redis::Client.new
  end

end
