require 'yammer'

Yammer.configure do |y|
  y.access_token = ENV.fetch('YAMMER_TOKEN')
end
