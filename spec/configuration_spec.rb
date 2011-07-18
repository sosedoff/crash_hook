require 'spec_helper'

describe 'CrashHook::Configuration' do
  it 'raises an exception if no url were provided' do
    proc { CrashHook::Configuration.new }.
      should raise_error CrashHook::ConfigurationError, ":url option required!"
  end
  
  it 'raises an exception on invalid url method' do
    proc {
      CrashHook::Configuration.new(
        :url => 'http://foo.com',
        :method => :foo
      )
    }.should raise_error CrashHook::ConfigurationError, "foo is not a valid :method option."
  end
  
  it 'raises an exception on invalid class name' do
    proc {
      c = CrashHook::Configuration.new(
        :url => 'http://foo.com',
        :ignore => ['FakeError']
      )  
    }.should raise_error CrashHook::ConfigurationError, "undefined object: FakeError"
  end
  
  it 'has an unique list of ignored exceptions' do
    c = CrashHook::Configuration.new(
      :url => 'http://foo.com',
      :ignore => [
        'RuntimeError',
        RuntimeError
      ]
    )
    
    c.ignore.size.should == 1
    c.ignore_exception?(RuntimeError).should == true
  end
end
