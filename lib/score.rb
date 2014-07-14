class Score

  def initialize(game_id, cache: Rails.cache)
    @game_id = game_id
    @cache = cache
  end

  def silver
    @cache.read(cache_key(:silver)) || 0
  end

  def black
    @cache.fetch(cache_key(:black)) || 0
  end

  def increment(team)
    @cache.increment cache_key(team)
  end

  private

  def cache_key(team)
    [:score, @game_id, team].join(':')
  end

end
