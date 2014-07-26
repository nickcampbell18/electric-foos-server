class Team < ActiveRecord::Base

  enum team_colour: %i[silver black]

  belongs_to :game
  belongs_to :player_one, class_name: 'Player'
  belongs_to :player_two, class_name: 'Player'

  def players
    [player_one, player_two].compact
  end

  def as_json
    {
      type:    :team,
      colour:  team_colour,
      players: players.map(&:as_json),
      score:   score
    }
  end

  def self.find_by_game_and_colour(game, colour)
    integer = team_colours.fetch(colour.to_s)
    find_by game: game, team_colour: integer
  end

  def score
    Score.new(id).score
  end

end
