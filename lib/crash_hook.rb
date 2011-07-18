require 'crash_hook/version'
require 'crash_hook/errors'
require 'crash_hook/configuration'
require 'crash_hook/middleware'
require 'crash_hook/request'
require 'crash_hook/crash'

module CrashHook
  def self.configure(options)
    @@config = CrashHook::Configuration.new(options)
    @@config
  end
end
