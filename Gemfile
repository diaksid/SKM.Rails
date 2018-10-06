source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Shim to load environment variables
gem 'dotenv-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
# gem 'webpacker'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'duktape'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'

# Official Ruby on Rails specific tasks for Capistrano
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Use sqlite3 as the database for Active Record
  # gem 'sqlite3'
  # Acceptance test framework
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]


if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/
  gem 'rubocop', require: false
end

# Sprockets 3.x ES6 transformer
gem 'sprockets-es6'

# Wrapper for the Google Closure Compiler
gem 'closure-compiler'

# Slim templates generator
gem 'slim-rails'

# ActiveRecord plugin for managing lists
gem 'acts_as_list'
# Organise ActiveRecord model into a tree structure
gem 'ancestry'

# Static page caching for Action Pack
# gem 'actionpack-page_caching'
# Action caching for Action Pack
# gem 'actionpack-action_caching'

# Classier solution for file uploads for Rails
gem 'carrierwave', '~> 1.0'

# Flexible authentication solution
gem 'devise'
gem 'devise-i18n'

# Authorization Gem for Ruby on Rails
gem 'cancan'

# Paginator
gem 'kaminari'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Administration framework
gem 'activeadmin'
# Show ActiveAdmin index as a nested tree with drag'n'drop
gem 'active_admin-sortable_tree'
# jQuery UI for the Rails asset pipeline
gem 'jquery-ui-rails'

# A Lightweight Sass Tool Set
# gem 'bourbon'

# XML Sitemap generator
gem 'sitemap_generator'

# Cron jobs in Ruby
gem 'whenever', require: false

# ReCaptcha helpers
gem 'recaptcha'

# Collecting Locale data
gem 'rails-i18n', '~> 5.1'

# Code coverage for Ruby 1.9+
gem 'simplecov', require: false, group: :test

# High performance memcached client
gem 'dalli', group: :production
