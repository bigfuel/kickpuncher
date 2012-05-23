source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', git: 'git://github.com/rails/rails.git'

gem 'rails-api', git: 'git://github.com/spastorino/rails-api.git'

gem 'jquery-rails'

gem 'mongoid'
gem 'bson_ext'
gem 'acts_as_list_mongoid'
gem 'mongoid_taggable_with_context'

gem 'devise'
gem 'state_machine'
gem 'fog'
gem 'sinatra'
gem 'slim'
gem 'sidekiq'
gem 'kaminari'
gem 'koala'
gem 'mini_magick'
gem 'carrierwave'
gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'redis-store'
gem 'redis-rails'
gem 'feedzirra', '0.0.24'
gem 'profanity_filter'
gem 'validates_timeliness'
gem 'carmen'
gem 'pry-rails'
gem 'rabl'
gem 'yajl-ruby'
gem 'retriable'

# Use unicorn as the web server
gem 'unicorn'

group :test do
  gem 'turn'
  gem 'minitest'
  gem 'ffaker'
  gem "rack-test", require: "rack/test"
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'guard-minitest'
  gem 'minitest-spec-rails'
  gem 'minitest-matchers'
  gem 'valid_attribute'
  gem 'mocha', require: false
end

group :development do
  gem 'heroku'
  gem 'foreman'
  gem 'rails_best_practices'
  gem 'ruby-graphviz', require: 'graphviz'
  # gem 'metric_fu'
  # gem 'rack-perftools_profiler', :require => 'rack/perftools_profiler'
end

group :development, :test do
  gem 'awesome_print'
  gem 'fabrication', git: 'git://github.com/paulelliott/fabrication.git'
  gem 'guard'
  gem 'rb-fsevent'
  gem 'ruby_gntp'
  gem 'ruby-prof'
  gem 'pry-nav'
  gem 'pry-stack_explorer'
  # gem 'ruby-debug19', require: 'ruby-debug'
  # gem 'cover_me', '>= 1.0.0.pre2', require: false
end

group :production, :staging do
  gem 'exceptional'
  # gem 'rpm_contrib'
end