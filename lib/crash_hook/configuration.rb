require 'uri'

module CrashHook
  @@config = nil
  
  class Configuration
    ALLOWED_METHODS = [:get, :post, :put, :delete].freeze
    ALLOWED_FORMATS = [:form, :json, :yaml]
    
    attr_reader :url
    attr_reader :method
    attr_reader :ignore
    attr_reader :extra_params
    attr_reader :format
    attr_reader :logger
    
    # Initialize configuration. Options:
    #   :url    => Target url (required)
    #   :method => Request method (default: post)
    #   :format => Request format (default: json)
    #   :params => Additional parameters for the request
    #   :ignore => Set of exception classes to ignore
    #   :logger => Set logger class (default: none)
    #
    def initialize(options={})
      if options[:url].to_s.strip.empty?
        raise CrashHook::ConfigurationError, ":url option required!"
      end
      
      @url          = options[:url].to_s
      @method       = options.key?(:method) ? options[:method].to_sym : :post
      @format       = options.key?(:format) ? options[:format].to_sym : :json
      @extra_params = options[:params].kind_of?(Hash) ? options[:params] : {}
      @logger       = options[:logger]
      
      unless ALLOWED_METHODS.include?(@method)
        raise CrashHook::ConfigurationError, "#{@method} is not a valid :method option."
      end
      
      unless ALLOWED_FORMATS.include?(@format)
        raise CrashHook::ConfigurationError, "#{@format} is not a valid :format option."
      end
      
      @ignore = []
      @ignore += options[:ignore] if options[:ignore].kind_of?(Array)
      @ignore.map! { |c| c.to_s }
      @ignore.uniq!
    end
    
    # Returns true if specified exception class is ignored
    #
    def ignore_exception?(ex)
      @ignore.include?(ex.to_s) 
    end
    
    # Returns true if configuration has a logger
    def has_logger?
      !@logger.nil?
    end
  end
end