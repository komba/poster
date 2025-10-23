# Why

to make your life easier

## How?

```ruby
require "poster"
Poster::Base.products

Poster::Base.get("menu.getProducts")
```

## Monkey Patching
If you ever need to make custom calls (could be handy)
lib/poster.rb:
```ruby
module Poster
  class Base
    class << self
      def transactions(params={})
        get("dash.getTransactions", params.merge(include_products: true))
      end
    end
  end
end
```

## TODO
- use Faraday
- add tests
- add callback validation