class GameCreatorJob

  def self.perform(game_id, silver_team, black_team, timestamp)
    silvers = silver_team.map do |sig|
      Signature.find_or_create_by sig: sig
    end
    blacks = black_team.map do |sig|
      Signature.find_or_create_by sig: sig
    end

    Game.find(game_id).update_attributes silver_sig_one: silvers[0],
                                         silver_sig_two: silvers[1],
                                         black_sig_one:  blacks[0],
                                         black_sig_two:  blacks[1],
                                         created_at:     timestamp
  end

end
