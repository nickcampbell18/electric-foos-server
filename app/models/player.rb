class Player < ActiveRecord::Base

  before_save :init_stats_hash

  def self.find_by_signature(sig)
    where('? = ANY (signatures)', sig).first
  end

  def as_json(*args)
    {
      type:      :player,
      signature: signatures,
      name:      name,
      mugshot:   mugshot,
      permalink: permalink,
      stats:     DummyStats.new
    }
  end

  def first_name
    $1 if name =~ /(\w+)/
  end

  def small_mugshot
    mugshot.gsub(/256/, '50')
  end

  private

  def init_stats_hash
    self.stats ||= {}
    stats_will_change!
  end

end
