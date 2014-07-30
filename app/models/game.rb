class Game < ActiveRecord::Base

  FINAL_SCORE = 10

  has_many :teams, dependent: :destroy

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
      end_time:    ended_time_if_needed,
      duration:    duration
    }
  end

  def duration
    if ended
      (updated_at - created_at).to_i
    else
      (Time.now - created_at).to_i
    end
  end

  def ended_time_if_needed
    ended ? updated_at.iso8601 : nil
  end

  def last_goal_time
    teams.map(&:last_goal_time).max
  end

  def finish!(team)
    # Set the ended flag
    update ended: true
    # Mark a team as a winner
    team.update won: true
  end

  def unfinish!(team)
    update ended: false
    team.update won: false
  end

end
