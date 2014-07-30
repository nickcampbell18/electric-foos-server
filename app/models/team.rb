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
      goal_times: goal_times_in_seconds_since_start
    }
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

  def goal_times_in_seconds_since_start
    start_time = game.created_at
    goal_times.map do |time|
      (time - start_time).to_i
    end
  end

end
