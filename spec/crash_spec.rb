require 'spec_helper'

describe 'CrashHook::Crash' do
  it 'raises error if no configuration were provided' do
    proc { CrashHook::Crash.new(nil) }.
      should raise_error ArgumentError, "CrashHook::Configuration required!"
  end
  
  it 'raises error if no exception were provided' do
    proc { CrashHook::Crash.new(sample_configuration) }.
      should raise_error ArgumentError, "Exception required!"
  end
  
  it 'raises error if no environment configuration were provided' do
    e = ArgumentError.new("Sample message")
    
    proc { CrashHook::Crash.new(sample_configuration, e, nil) }.
      should raise_error ArgumentError, "Environment required!"
  end
end
