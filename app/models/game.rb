class Game < ActiveRecord::Base

  FINAL_SCORE = 10

  has_many :teams

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

end
