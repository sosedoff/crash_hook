require 'spec_helper'

describe 'CrashHook::Request' do
  class RequestTester
    extend CrashHook::Request
  end
  
  before :all do
    CrashHook::Configuration::ALLOWED_METHODS.each do |m|  
      FakeWeb.register_uri(m, "http://localhost:4567/test", :body => "")
    end
  end
    
  it 'sends a GET request' do
    RequestTester.get('http://localhost:4567/test', {:foo => 'bar'})
  end
  
  it 'sends a POST request' do
    RequestTester.post('http://localhost:4567/test', {:foo => 'bar'})
  end
  
  it 'sends a PUT request' do
    RequestTester.put('http://localhost:4567/test', {:foo => 'bar'})
  end
  
  it 'sends a DELETE request' do
    RequestTester.delete('http://localhost:4567/test', {:foo => 'bar'})
  end
end
