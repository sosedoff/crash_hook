require 'rest-client'

module CrashHook
  class Crash
    include CrashHook::Request
    
    # Initialize a new Crash object
    #   config    => CrashHook::Configuration object
    #   exception => Exception raised from middleware
    #   env       => Environment variable
    #
    def initialize(config, exception=nil, env={})
      unless config.kind_of?(CrashHook::Configuration)
        raise ArgumentError, "CrashHook::Configuration required!"
      end
      
      raise ArgumentError, "Exception required!" if exception.nil?
      raise ArgumentError, "Environment required!" if env.nil?
      
      @config = config
      @payload = CrashHook::Payload.new(exception, env, @config.extra_params)
    end
    
    # Send notification to the endpoint
    def notify
      begin
        request(@config.method, @config.url, payload_data, @config.format)
        true
      rescue Exception => ex
        log_error(ex) if @config.has_logger?
        false
      end
    end
    
    private
    
    # Log CrashHook delivery error
    #
    def log_error(ex)
      if @config.logger.respond_to?(:error)
        @config.logger.error("CrashHook Error: #{ex.inspect}")
      elsif @config.logger.kind_of?(IO)
        @config.logger.puts("CrashHook Error: #{ex.inspect}")
      end
    end
    
    # Returns data formatted into config's format
    # 
    def payload_data
      case @config.format
      when :json
        @payload.to_json
      when :yaml
        @payload.to_yaml
      else
        @payload.to_hash
      end
    end
  end
end
