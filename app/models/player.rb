class Player < ActiveRecord::Base

  before_save :init_stats_hash

  def self.find_by_signature(sig)
    where('? = ANY (signatures)', sig).first
  end

  def as_json(*args)
    {
      type:      :player,
      id:        id,
      signature: signatures,
      name:      name,
      mugshot:   large_mugshot,
      sm_mug:    small_mugshot,
      permalink: permalink,
      stats:     stats
    }
  end

  def first_name
    $1 if name =~ /(\w+)/
  end

  def large_mugshot
    self[:mugshot] || 'https://mug0.assets-yammer.com/mugshot/images/256x256/no_photo.png'
  end

  def small_mugshot
    self[:mugshot] ? mugshot.gsub(/256/, '50') : 'https://mug0.assets-yammer.com/mugshot/images/50x50/no_photo.png'
  end

  private

  def init_stats_hash
    self.stats ||= {}
    stats_will_change!
  end

end
