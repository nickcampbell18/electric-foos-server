class Team < ActiveRecord::Base

  enum team_colour: %i[silver black]

  belongs_to :game
  belongs_to :player_one, class_name: 'Player'
  belongs_to :player_two, class_name: 'Player'

  def players
    [player_one, player_two]
  end

  def as_json(*args)
    {
      id:         id,
      type:       :team,
      colour:     team_colour,
      players:    players.map(&:as_json),
      score:      score,
      goal_times: goal_times,
      won?:       won?
    }
  end

  def self.find_all_by_player(player)
    where('player_one_id = ? OR player_two_id = ?', player.id, player.id)
  end

  def self.find_by_game_and_colour(game, colour)
    integer = team_colours.fetch(colour.to_s)
    find_by game: game, team_colour: integer
  end

  delegate :score, :score=,
           :score_goal!, :cancel_goal!,
           :goal_times, :last_goal_time,
           to: :scorer

  private

  def scorer
    Scorer.new(id)
  end

end
