class Game < ActiveRecord::Base

  belongs_to :silver_player_one, foreign_key: :silver_player_one,
                                 class_name: 'Player'
  belongs_to :silver_player_two, class_name: 'Player'

  belongs_to :black_player_one, class_name: 'Player'
  belongs_to :black_player_two, class_name: 'Player'

  def teams
    [
      Team.new(silver_player_one, silver_player_two),
      Team.new(black_player_one, black_player_two)
    ]
  end

end
