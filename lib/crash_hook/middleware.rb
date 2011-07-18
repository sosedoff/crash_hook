module CrashHook
  class Middleware
    attr_reader :config
    
    def initialize(app, options={})
      @app = app
      @config = CrashHook.configure(options)
    end
    
    def call(env)
      @app.call(env)
      rescue Exception => exception
      unless @config.ignore_exception?(exception.class.to_s)
        ex = CrashHook::Crash.new(@config, exception, env)
        ex.notify
      end
      raise exception
    end
  end
end