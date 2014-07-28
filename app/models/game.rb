class Game < ActiveRecord::Base

  FINAL_SCORE = 10

  has_many :teams
  has_many :goals, through: :teams

  scope :current, -> do
    where(ended: false).order('updated_at DESC').first
  end

  def as_json(*args)
    {
      type: :game,
      id: id,
      teams: teams.map(&:as_json),
      final_score: FINAL_SCORE,
      ended: false
    }
  end

  def last_goal_time
    if last_goal = goals.last
      last_goal.created_at
    end
  end

end
