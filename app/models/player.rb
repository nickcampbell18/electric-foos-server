class Player < ActiveRecord::Base

  def self.find_by_signature(sig)
    where('? = ANY (signatures)', sig).first
  end

  def as_push
    {
      signature: signatures,
      name:      name,
      mugshot:   mugshot
    }
  end

end
