class GlobalStatistician

  # This class stores overall metrics, such as
  # - number of goals
  # - longest streak
  # - number of games
  # - fastest goal

  def self.perform
    new.call
  end

  def as_json(*args)
    if obj = Redis.new.get(:global_stats)
      JSON.parse(obj)
    else
      {}
    end
  end

  def call
    stats = {}
    stats[:fastest_goal]       = fastest_goal
    stats[:total_games_played] = total_games_played
    stats[:total_goals_scored] = total_goals_scored
    stats[:best_score]         = best_score
    stats[:longest_game]       = game_length(:max)
    stats[:shortest_game]      = game_length(:min)
    stats[:average_winning_score]  = average_score(true)
    stats[:average_losing_score]   = average_score(false)
    stats[:longest_winning_streak] = longest_winning_streak

    Redis.new.set(:global_stats, stats.to_json)
  end

  private

  def redis
    Redis.new
  end

  def fastest_goal
    Array(Team.all.map(&:goal_times)).
      flatten.
      find_all {|i| i > 0 }.
      min
  end

  def total_games_played
    Game.count
  end

  def total_goals_scored
    Team.all.map(&:score).inject :+
  end

  def best_score
    Team.all.map(&:score).max
  end

  def average_score(winner=true)
    teams = Team.where('won = ?', winner)
    return 0 unless teams.any?
    teams.map(&:score).inject(:+).to_f / teams.size
  end

  def longest_winning_streak
    Player.all.map { |p| p.stats['longest_winning_streak'] }.compact.max
  end

  # Operation = :max || :min
  def game_length(operation)
    Game.all.find_all(&:ended?).map(&:duration).send operation
  end

end
