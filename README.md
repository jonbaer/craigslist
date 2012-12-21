# Craigslist GEM [![Build Status](https://secure.travis-ci.org/gregstallings/craigslist.png)](http://travis-ci.org/gregstallings/craigslist)

Unofficial Ruby interface for programmatically accessing Craigslist listings. This gem is intended for research purposes only.

## Installation

Add this line to your application's Gemfile:

    gem 'craigslist'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install craigslist

## Usage

```ruby
require 'craigslist'

# Return an array of posts for a city and category.
Craigslist.seattle.for_sale.last

# Note that any additional city/category in the method chain will override any
# previous city/category.
# In this example 'bikes' is the category that is used, not 'for sale'.
# Having #for_sale before #bikes in the method chain may give some added
# readability in the expression without adding any performance cost.
Craigslist.seattle.for_sale.bikes.last

# Also note that category can come before city in the method chain with no
# change in results.
Craigslist.for_sale.seattle.last

# The max_results can be specified in an argument to #last.
# Currently, the gem is only fetching the first page of results which limits
# results to a max of 100.
Craigslist.seattle.for_sale.last(40)

# You can also access last via a dynamic finder method in this format.
Craigslist.seattle.for_sale.last_40

# #posts is an alias of #last.
Craigslist.for_sale.seattle.posts

# Return an array of supported cities.
Craigslist.cities

# Return an array of supported categories.
Craigslist.categories

# Return true if the city is supported.
Craigslist.city?('seattle')
=> true

# Return true if the category is supported.
Craigslist.category?('for_sale')
=> true
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Notice

This software is not associated with Craigslist and is intended for research purposes only. Any use outside of this may be a violation of Craigslist terms of use.

## License

(The MIT License)

Copyright (c) 2012 Greg Stallings

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
