class Score

  def initialize(team_id, cache: Rails.cache)
    @team_id = team_id
    @cache = cache
  end

  def score
    @cache.fetch(cache_key, raw: true) { 0 }.to_i
  end

  def score=(score)
    @cache.set cache_key, score, raw: true
  end

  def increment
    @cache.increment cache_key
  end

  private

  def cache_key
    [:score, :team, @team_id].join(':')
  end

end
