class GameCleanerUpperer

  def self.perform(latest_game_id)
    other_games = Game.where('ended = false AND id != ?', latest_game_id)

    # Go and mark the older games as "ended".
    other_games.each do |game|
      end_time = game.last_goal_time || Time.now
      game.update_attributes ended: true,
                             updated_at: end_time
    end
  end

end
