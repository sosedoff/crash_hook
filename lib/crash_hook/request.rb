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
      RestClient::Request.execute(
        :method       => method,
        :url          => url,
        :payload      => payload,
        :headers      => {},
        :timeout      => TIMEOUT,
        :open_timeout => OPEN_TIMEOUT
      )
    end
  end
end
