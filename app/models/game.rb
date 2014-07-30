class Game < ActiveRecord::Base

  FINAL_SCORE = 10

  has_many :teams

  def self.current
    with_includes_and_sorted.where('ended IS NOT true').limit(1).first
  end

  def self.with_includes_and_sorted
    order('updated_at DESC').
    includes teams: [:player_one, :player_two]
  end

  def as_json(*args)
    {
      type:  :game,
      id:    id,
      teams: teams.map(&:as_json),
      ended: ended?,
      final_score: FINAL_SCORE,
      start_time:  created_at.iso8601,
      end_time:    ended_time_if_needed
    }
  end

  def ended_time_if_needed
    ended ? updated_at.iso8601 : nil
  end

  def last_goal_time
    teams.map(&:last_goal_time).max
  end

end
