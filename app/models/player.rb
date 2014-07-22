class Player < ActiveRecord::Base

  def self.find_by_signature(sig)
    where('? = ANY (signatures)', sig).first
  end

  def as_push(signature: signatures.first)
    {
      type:      :player,
      signature: signature,
      name:      name,
      mugshot:   mugshot,
      permalink: permalink
    }
  end

end
