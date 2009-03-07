class PerformanceLogger

  def initialize(app)
    @app = app
  end

  def call(env)
    puts env.inspect
    @app.call(env)
  end
end