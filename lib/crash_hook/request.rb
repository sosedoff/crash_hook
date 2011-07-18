module CrashHook
  module Request
    TIMEOUT = 4
    OPEN_TIMEOUT = 4
    
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
        :timeout      => TIMEOUT,
        :open_timeout => OPEN_TIMEOUT
      }
      opts.merge!(:content_type => :json) if format == :json
      
      RestClient::Request.execute(opts)
    end
  end
end
