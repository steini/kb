class PerformanceLogger

  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    headers["test"] = "test"
    [status, headers, body]
  end
end