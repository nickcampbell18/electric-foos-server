class Scorer

  def initialize(team_id)
    @team_id = team_id
    @store   = Redis::Client.new
  end

  def score
    run(:llen)
  end

  def score_goal!(time=Time.now.to_i)
    run(:rpush, time)
  end

  def cancel_goal!
    run(:rpop)
    run(:llen)
  end

  def goal_times
    run(:lrange, 0, -1).map { |seconds| Time.at seconds.to_i }
  end

  def last_goal_time
    run(:lrange, -1, -1).map { |s| Time.at s.to_i }.first
  end

  def score=(count)
    goal_times, goals_count = run(:lrange, 0, -1), score
    return count if goals_count == count

    if count < goals_count
      items_to_remove = goals_count - count
      items_to_remove.times { cancel_goal! }
    else
      items_to_add = count - goals_count
      times = items_to_add.times.map { Time.now.to_i }
      run(:rpush, times)
    end

    count
  end

  private

  def run(operation, *values)
    args = [operation, cache_key, *values].compact
    @store.call args
  end

  def cache_key
    [:goals, @team_id].join ':'
  end



end
