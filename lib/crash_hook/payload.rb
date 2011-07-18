require 'multi_json'
require 'yaml'

module CrashHook
  class Payload
    include CrashHook::Serializer
    
    attr_reader :exception
    attr_reader :environment
    attr_reader :framework
    attr_reader :version
    attr_reader :extra_params
    
    # Initialize a new CrashHook::Payload object
    #   exception    => Exception object instance
    #   env          => Environment hash
    #   extra_params => Additional parameters
    # 
    def initialize(exception, env, extra_params={})
      @exception = {
        :class_name => exception.class.to_s,
        :message    => exception.message,
        :backtrace  => exception.backtrace,
        :timestamp  => Time.now
      }
      
      @environment  = clean_non_serializable_data(env)
      @version      = CrashHook::VERSION
      @framework    = 'rack'
      @framework    = 'rails'   if defined?(Rails)
      @framework    = 'sinatra' if defined?(Sinatra)
      @extra_params = extra_params.kind_of?(Hash) ? extra_params : {}
    end
    
    # Returns HASH representation of payload
    def to_hash
      {
        :exception   => @exception,
        :environment => @environment,
        :version     => @version,
        :framework   => @framework
      }
    end
    
    # Returns JSON representation of payload
    #
    def to_json
      @extra_params.delete(:crash)
      @extra_params.delete('crash')
      MultiJson.encode({:crash => self.to_hash}.merge(@extra_params))
    end
    
    # Returns YAML representation of payload
    # 
    def to_yaml
      YAML.dump({:crash => self.to_hash})
    end
    
    # Returns XML representation of payload
    # 
    def to_xml
      # Not Implemented Yet
    end
  end
end
