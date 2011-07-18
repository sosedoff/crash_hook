require 'spec_helper'

describe 'CrashHook::Middleware' do
  before do
    @env = Rack::MockRequest.env_for("/")
  end
  
  def build_stack(endpoint = safe_endpoint, url='http://foo.bar/exception')
    Rack::Builder.new do
      use CrashHook::Middleware, :url => url
      run endpoint
    end
  end
  
  it 'does nothing if no errors occurred' do
    result = build_stack.call(@env)
    result.status.should == 200
  end
  
  it 'sends notification to the url on exception' do
    FakeWeb.register_uri(:post, "http://foo.bar/exception", :body => fixture('stack.txt'))
    
    proc { build_stack(raise_endpoint(ArgumentError, "missing something")).call(@env) }.
      should raise_error ArgumentError, "missing something"
  end
  
  it 'does not produce any errors on invalid http endpoint' do
    FakeWeb.register_uri(:post, "http://foo.bar/exception2", :body => fixture('stack.txt'), :status => ["404", "Not Found"])
    proc { build_stack(raise_endpoint(ArgumentError, "missing something")).call(@env) }.
      should raise_error ArgumentError, "missing something"
  end
end
