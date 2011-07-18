module CrashHook
  module Request
    TIMEOUT = 4
    OPEN_TIMEOUT = 4
    
    CONTENT_TYPES = {
      :form => 'application/x-www-form-urlencoded',
      :json => 'application/json',
      :yaml => 'application/x-yaml'
    }.freeze
    
    def get(url, payload={}, format=:json)
      request(:get, url, payload, format)
    end
    
    def post(url, payload={}, format=:json)
      request(:post, url, payload, format)
    end
    
    def put(url, payload={}, format=:json)
      request(:put, url, payload, format)
    end
    
    def delete(url, payload={}, format=:json)
      request(:delete, url, payload, format)
    end
    
    protected
    
    def request(method, url, payload, format)
      opts = {
        :method       => method,
        :url          => url,
        :payload      => payload,
        :headers      => {:content_type => CONTENT_TYPES[format]},
        :timeout      => TIMEOUT,
        :open_timeout => OPEN_TIMEOUT
      }
      
      RestClient::Request.execute(opts)
    end
  end
end
