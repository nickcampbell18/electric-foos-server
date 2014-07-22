class Team < ActiveRecord::Base

  enum team_colour: %i[silver black]

  belongs_to :game
  belongs_to :player_one, class_name: 'Player'
  belongs_to :player_two, class_name: 'Player'

  def players
    [player_one, player_two].compact
  end

  def as_push
    {
      type:    :team,
      colour:  team_colour,
      players: players.map(&:as_push),
      score:   score
    }
  end

  def score
    Score.new(game_id).send team_colour.to_sym
  end

end
