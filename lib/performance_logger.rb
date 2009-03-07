class PerformanceLogger

  def initialize(app)
    @app = app
  end

  def call(env)
    logger.debug env.inspect
    @app.call(env)
  end
end