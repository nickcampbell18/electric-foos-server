class Game < ActiveRecord::Base

  has_many :teams

  def score
    [silver_score, black_score].join ' - '
  end

  private

  def silver_score
    Score.new(id).silver
  end

  def black_score
    Score.new(id).black
  end

end
