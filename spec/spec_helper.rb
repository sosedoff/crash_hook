$:.unshift File.expand_path("../..", __FILE__)

require 'rack/mock'
require 'fakeweb'
require 'crash_hook'

FakeWeb.allow_net_connect = false

def fixture_path(file=nil)
  path = File.expand_path("../fixtures", __FILE__)
  path = File.join(path, file) unless file.nil?
  path
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end

def safe_endpoint(msg = "OK")
  proc { |e| Rack::Response.new(msg) }
end

def raise_endpoint(exception, msg)
  proc { |e| raise exception, msg }
end