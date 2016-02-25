# SinatraPermittedParams

A simple parameter filtering for Sinatra

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra_permitted_params'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra_permitted_params

## Usage

This gems allows you to define your permitted params.

Add it as a helper in your sinatra App:

```ruby
  class App < Sinatra::Base
    helpers Sinatra::PermittedParams
    #...
```

And define your permitted params:

```ruby
  require 'sinatra/base'
  require 'sinatra/permitted_params'

  class App < Sinatra::Base
    helpers Sinatra::PermittedParams

    # GET /comment?title=comment&body=new%20params%20gems
    # GET /comment?title=comment&body=new%20params%20gems&user=new_user  raises <Sinatra::PermittedParams::UnpermittedParamsError: Unpermitted params found: invalid>
    post '/comment' do
      permitted_params = permitted_params([:title, :body])
      comment = Comment.create(permitted_params)

      #...
    end
  end
```

If a parameter different than the declared ones is received, then it raises a Sinatra::PermittedParams::UnpermittedParamsError.

Adding keys to the option 'ignore' allows you to define the params you want to filter without raising the error:

```ruby
  post '/comment' do
    permitted_params = permitted_params([:title, :body], ignore: [:user])
    comment = Comment.create(permitted_params)

    #...
  end
```

In this case the param 'user' will be ignored, no error will be raised and
the permitted_params will return a hash with title and body.

You can intercept the error with a Sinatra ```error do...end``` block

```ruby
error Sinatra::PermittedParams::UnpermittedParamsError do
  #...
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sinatra_permitted_params/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
