require 'rest-client'

module CrashHook
  class Crash
    
    # Initialize a new Crash object
    #   config    => CrashHook::Configuration object
    #   exception => Exception raised from middleware
    #   env       => Environment variabled
    #
    def initialize(config, exception, env)
      unless config.kind_of?(CrashHook::Configuration)
        raise ArgumentError, "CrashHook::Configuration required!"
      end
      
      @config = config
      @payload = {
        :exception   => {
          :class     => exception.class.to_s,
          :message   => exception.message,
          :backtrace => exception.backtrace
        },
        :environment => env
      }
    end
    
    # Send notification to the endpoint
    def notify
      begin
        RestClient.send(@config.method, @config.url, :crash => @payload)
        true
      rescue Exception => ex
        $stderr.puts("CrashHook Error: #{ex.inspect}")
        false
      end
    end
  end
end
