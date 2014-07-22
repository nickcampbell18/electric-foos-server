require 'em-websocket'

EM.run do

  @channel = EM::Channel.new

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

  puts "Server started..."

end
