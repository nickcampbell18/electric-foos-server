class DummyStats

  def as_json(*args)
    total = rand(50)
    wins = rand(30)
    losses = total - wins
    {
      fastest_goal: 4.3,
      total_games_played: total,
      total_wins: wins,
      total_losses: losses,
      best_score: 10,
      average_score: 8.3,
      current_winning_streak: 2,
      longest_winning_streak: 7
    }
  end

end
