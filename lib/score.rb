class Score

  def initialize(game_id, team_id, cache: Rails.cache)
    @game_id = game_id
    @team_id = team_id
    @cache = cache
  end

  def score
    @cache.fetch(cache_key, raw: true) { 0 }.to_i
  end

  def increment
    @cache.increment cache_key
  end

  private

  def cache_key
    [:score, @game_id, @team_id].join(':')
  end

end
