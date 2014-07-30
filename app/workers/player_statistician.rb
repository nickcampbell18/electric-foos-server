class PlayerStatistician

  # This class iterates through all the players, and sets the various
  # "stats" attributes on the object, based on the latest game data.

  def self.perform
    new.call
  end

  def call
    Player.all.each do |player|
      teams = Team.find_all_by_player(player)
      stats = Hash.new { 0 }
      stats[:fastest_goal]       = fastest_goal(teams)
      stats[:total_games_played] = teams.count
      stats[:total_wins]         = total_wins(teams)
      stats[:best_score]         = best_score(teams)
      stats[:worst_score]        = worst_score(teams)
      stats[:average_score]      = average_score(teams)

      all_streaks = streaks(teams)
      stats[:current_winning_streak] = all_streaks.last
      stats[:longest_winning_streak] = all_streaks.max

      stats[:total_losses] = stats[:total_games_played] - stats[:total_wins]

      player.update stats: stats
    end
  end

  private

  def fastest_goal(teams)
    teams.map(&:goal_times).flatten.min
  end

  def total_wins(teams)
    teams.find_all(&:won?).count
  end

  def best_score(teams)
    teams.map(&:score).max
  end

  def worst_score(teams)
    teams.map(&:score).min
  end

  def average_score(teams)
    scores = teams.map(&:score)
    scores.inject(:+).to_f / scores.size
  end

  def streaks(teams)
    wins = teams.map(&:won?)
    actual = wins.first
    groups = wins.slice_before do |e|
      expected, actual = actual, e
      expected != actual
    end.to_a

    groups.
      find_all { |g| g[0] }. # Just return groups of "true"
      map(&:size)
  end

end
