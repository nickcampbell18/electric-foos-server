require 'json'
require 'redis'

class Publisher

  def self.publish(object)
    msg = JSON.generate(object)
    Redis.new.publish 'ws', msg
  end

end
