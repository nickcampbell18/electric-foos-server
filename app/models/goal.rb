class Goal < ActiveRecord::Base

  belongs_to :game
  belongs_to :team

  after_create :update_score

  private

  def update_score
    Score.new(team_id).increment
  end

end
