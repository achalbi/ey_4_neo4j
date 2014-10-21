source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.2'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem "will_paginate"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'

gem 'omniauth-facebook'
#gem 'omniauth-identity'

gem "geocoder"
gem 'rails4-autocomplete'

gem "font-awesome-rails"
gem 'koala'
gem 'newrelic_rpm'

#gem 'faker', '1.0.1'
gem 'jquery-turbolinks'
#gem 'purecss'

group :production do
#	gem 'puma'
  	gem 'rails_12factor'
end

gem 'jquery-ui-rails'
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "string-urlize"  # for making the title the primary key and work as an URL, see Neo4j.rb id_property

platforms :jruby do
  gem 'neo4j-community', '~> 2.0.0'
end

gem 'sidekiq'
gem 'sinatra', require: false
gem 'slim'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#gem 'thin'
gem 'neo4j', '3.0.0.rc.3'

group :development do
  gem 'spring'
  gem 'os'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'debugger'

  gem 'foreman'
end
