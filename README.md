# mundipagg-one-ruby

### Mundipagg Gem Download
https://rubygems.org/gems/mundipagg_api

```ruby
$ gem install mundipagg_api
```

```ruby
require 'mundipagg_api'
```

Ruby DevKit is required.

### About Windows
The recommended Windows version of Ruby is Ruby 2.1.
For gems work correctly it'll be necessary run the following commands:

No Windows a versão do Ruby recomendada é a 2.1.
Para que todas as gemas funcionem corretamente é necessário realizar o seguinte processo:
```ruby
$ gem install rubygems-update
$ update_rubygems
$ gem update --system
```
### Required Gems
```ruby
$ gem install rest-client
$ gem install rspec
$ gem install nori
$ gem install gyoku
$ gem install nokogiri
$ gem install ffi
$ gem install bundler
```
### Bundler
Run the following commands to install gems:

Rode os seguintes comandos para instalar as gems:
```ruby
$ gem install bundler
$ bundle install
```

Running tests with `bundle exec`:

Rodando testes com `bundle exec`:
```ruby
$ bundle exec rspec spec/integration/gateway_spec.rb
```

Running tests with `rake`:

Rodando testes com `rake`:

```ruby
$ rake
```

## Code Examples

You can access all the code examples (HERE, the Wiki page!)[https://github.com/mundipagg/mundipagg-one-ruby/wiki]