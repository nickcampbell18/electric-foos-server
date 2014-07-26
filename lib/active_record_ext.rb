class ActiveRecord::Base

  # This will almost certainly haunt me.
  def self.find(*args)
    super
  rescue ActiveRecord::StatementInvalid => e
    if e.message.match(/syntax\sfor\suuid/)
      return raise ActiveRecord::RecordNotFound
    else
      raise e
    end
  end

end
