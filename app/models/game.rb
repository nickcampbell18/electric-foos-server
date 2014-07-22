class Game < ActiveRecord::Base

  has_many :teams

  def score
    [silver_score, black_score].join ' - '
  end

  def as_push
    {
      type: 'Game',
      id: id,
      silver_team: teams.first.as_push,
      black_team:  teams.last.as_push
    }
  end

  private

  def silver_score
    Score.new(id).silver
  end

  def black_score
    Score.new(id).black
  end

end
