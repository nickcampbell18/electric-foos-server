class GoalCreatorJob

  def self.perform(game_id, team, timestamp)
    Goal.create game_id: game_id, team: team, created_at: timestamp
    Score.new(game_id).increment(team)
    Rails.logger.info "Created goal for game #{game_id} and team #{team}"
  end

end
