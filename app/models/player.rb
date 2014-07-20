class Player < ActiveRecord::Base

  def self.find_by_signature(sig)
    where('? = ANY (signatures)', sig).first
  end

end
