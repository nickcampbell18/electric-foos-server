require 'json'
require 'redis'

class Publisher

  def self.publish(object)
    if object.respond_to?(:as_json)
      object = object.as_json
    end
    msg = JSON.generate(object)
    Redis.new.publish 'ws', msg
  end

end
