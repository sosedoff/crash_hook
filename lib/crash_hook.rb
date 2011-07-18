require 'crash_hook/version'
require 'crash_hook/errors'
require 'crash_hook/configuration'
require 'crash_hook/middleware'
require 'crash_hook/request'
require 'crash_hook/serializer'
require 'crash_hook/crash'

module CrashHook
  # Set global configuration
  # 
  def self.configure(options)
    @@config = CrashHook::Configuration.new(options)
    @@config
  end
  
  # Manually sent notification
  #   exception => Exception object
  #   env       => Environment hash
  #
  def self.notify(exception, env)
    if @@config.nil?
      raise CrashHook::ConfigurationError, "No configuration were provided."
    end
    CrashHook::Crash.new(@@config, exception, env)
  end
end
