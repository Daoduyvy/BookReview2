# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.3'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .coffee assets and views
gem 'ckeditor', github: 'galetahub/ckeditor'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '~> 4.7', '>= 4.7.1'
gem 'jbuilder', '~> 2.5'
gem 'paperclip', '~> 6.0.0'
gem 'parser', '~> 2.6', '>= 2.6.5.0'
gem 'rubocop', require: false
gem 'simple_form', '~> 5.0', '>= 5.0.1'
gem 'turbolinks', '~> 5'
gem 'will_paginate' 
gem "font-awesome-rails"
gem 'carrierwave'
gem 'kaminari'
gem "cancancan"
gem 'rack','>= 2.0.8'
gem 'faker'
gem 'rails-i18n'
gem 'flag-icons-rails'
gem 'chartkick'
gem 'groupdate'
# gem 'redis', '~> 4.0' q
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
