class Game < ActiveRecord::Base

  FINAL_SCORE = 10

  has_many :teams

  def as_push
    {
      type: :game,
      id: id,
      teams: teams.map(&:as_push),
      final_score: FINAL_SCORE,
      ended: false
    }
  end

end
