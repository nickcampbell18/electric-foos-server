require 'em-websocket'
require 'em-hiredis'

EM.run do

  @channel = EM::Channel.new

  @redis = EM::Hiredis.connect.pubsub
  @redis.subscribe('ws')
  @redis.on(:message) do |_, message|
    puts "redis -> #{message}"
    @channel.push message
  end

  EM::WebSocket.run(:host => "0.0.0.0", :port => 9090) do |ws|

    ws.onopen {
      sid = @channel.subscribe { |msg| ws.send msg }
      @channel.push 'subscription %s created' % sid

      ws.onmessage do |msg|
        @channel.push "#{sid}: #{msg}"
      end

      ws.onclose {
        @channel.unsubscribe(sid)
      }
    }

  end

  EM.add_timer(5) do
    @channel.push "NOTHING"
  end

  puts "Server started..."

end
