class Cors < Struct.new(:app)

  def call(env)
    status, headers, body = app.call(env)
    headers['Access-Control-Allow-Origin'] = '*'
    [status, headers, body]
  end

end
