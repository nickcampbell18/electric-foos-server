class DummyStats

  def as_json(*args)
    total = rand(100)
    {
      fastest_goal: 3,
      total_games_played: total,
      total_goals_scored: total*17,
      best_score: 10,
      average_score: 8.3,
      longest_winning_streak: 7,
      shortest_game: 120,
      longest_game: 600
    }
  end

end
