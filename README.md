# CrashHook

CrashHook is a rack middleware for handling exception in your rack-based application.

It sends a http request with exception information, backtrace and environment details to your url via specified method.

## Installation

    gem install crash_hook

## Usage

### Rails 3

``` ruby
YOUR_RAILS_APP::Application.config.middleware.use CrashHook::Middleware, {
  :url => 'YOUR_URL'
}
```

You can add any exceptions into ignore list:

``` ruby
YOUR_RAILS_APP::Application.config.middleware.use CrashHook::Middleware, {
  :url => 'YOUR_URL',
  :ignore => [
    'NoMethodError'
  ]
}
```

### Sinatra

```ruby
errors do
  CrashHook.notify(request.env['sinatra.error'], request.env)
end

Please note that this will work only in production mode,
since in development mode Sinatra is overriding this method with a nice looking exception backtrace page.

```

### General

In other rack apps (config.ru):

``` ruby
require 'crash_hook'

use CrashHook::Middleware {
  :url => 'YOUR_URL',
  :method => :post
}
```
    
## Options

You can use these options during configuration:

- :url    &mdash; Target URL (**required**)
- :method &mdash; Request method *(default: :post)*
- :params &mdash; Extra parameters for the request *(ex.: api key, app ID, etc.)*
- :format &mdash; Report format (:form, :json, :yaml), *(default: json)*
- :ignore &mdash; Array of exception class names you want to ignore, *(default: [])*
- :logger &mdash; Set a logger for delivery errors, *(default: nil)*

## Payload

Each request has a following structure:

    crash:
      exception:
        class_name: "Exception class name"
        message: "Exception message"
        backtrace: "Exception backtrace"
      environment: "rack request environment"
      framework: "rails"
      version: "crash_hook version"
      
Framework is being auto-detected and could one of the following:

- rack (default)
- rails
- sinatra

## License

Copyright © 2011 Dan Sosedoff.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.