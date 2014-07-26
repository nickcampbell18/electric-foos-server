class PlayerCalculatorJob

  def self.perform(game_id)
    game = Game.find(game_id)

    return true if game.teams.any?

    silvers = game.unclaimed_signatures['silver_team']
    blacks  = game.unclaimed_signatures['black_team']

    silver_players = silvers.map do |sig|
      Player.find_by_signature(sig)
    end

    game.teams.create player_one: silver_players[0],
                      player_two: silver_players[1],
                      team_colour: :silver

    black_players = blacks.map do |sig|
      Player.find_by_signature(sig)
    end

    game.teams.create player_one: black_players[0],
                      player_two: black_players[1],
                      team_colour: :black
  end

end
