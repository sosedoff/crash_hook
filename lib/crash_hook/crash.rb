require 'rest-client'

module CrashHook
  class Crash
    include CrashHook::Request
    include CrashHook::Serializer
    
    # Initialize a new Crash object
    #   config    => CrashHook::Configuration object
    #   exception => Exception raised from middleware
    #   env       => Environment variabled
    #
    def initialize(config, exception=nil, env={})
      unless config.kind_of?(CrashHook::Configuration)
        raise ArgumentError, "CrashHook::Configuration required!"
      end
      
      raise ArgumentError, "Exception required!" if exception.nil?
      raise ArgumentError, "Environment required!" if env.nil?
      
      @config = config
      @payload = {
        :exception    => {
          :class_name => exception.class.to_s,
          :message    => exception.message,
          :backtrace  => exception.backtrace,
          :timestamp  => Time.now.utc
        },
        :environment  => clean_non_serializable_data(env),
        :crash_hook   => {
          :version    => CrashHook::VERSION
        }
      }
    end
    
    # Send notification to the endpoint
    def notify
      headers = {}
      data = {:crash => @payload}.merge(@config.extra_params)
      if @config.format == :json
        headers[:content_type] = 'application/json'
      end
      
      begin
        request(@config.method, @config.url, data, @config.format)
        true
      rescue Exception => ex
        log_error(ex) if @config.has_logger?
        false
      end
    end
    
    private
    
    # Log CrashHook delivery error
    def log_error(ex)
      if @config.logger.respond_to?(:error)
        @config.logger.error("CrashHook Error: #{ex.inspect}")
      elsif @config.logger.kind_of?(IO)
        @config.logger.puts("CrashHook Error: #{ex.inspect}")
      end
    end
  end
end
