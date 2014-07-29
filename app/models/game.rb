class Game < ActiveRecord::Base

  FINAL_SCORE = 10

  has_many :teams

  def self.current
    where('ended IS NOT true').order('updated_at DESC').limit(1).first
  end

  def as_json(*args)
    {
      type: :game,
      id: id,
      teams: teams.map(&:as_json),
      final_score: FINAL_SCORE,
      ended: ended?
    }
  end

  def last_goal_time
    teams.map(&:last_goal_time).max
  end

end
