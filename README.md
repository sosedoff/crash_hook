# CrashHook

CrashHook is a rack middleware for handling exception in your rack-based application.

It sends a http request with exception information, backtrace and environment details to your url via post method.

## Installation

    gem install crash_hook

## Usage

In Rails 3 apps:

    YOUR_RAILS_APP::Application.config.middleware.use CrashHook::Middleware, {
      :url => 'YOUR_URL'
    }

In other rack apps (config.ru):

    require 'crash_hook'

    use CrashHook::Middleware {
      :url => 'YOUR_URL',
      :method => :post
    }

Copyright © 2011 Dan Sosedoff.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.