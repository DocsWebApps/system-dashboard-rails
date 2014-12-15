source 'https://rubygems.org'
# Ruby version
ruby '2.1.5'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.0.rc3'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.17.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.0.beta1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use HAML for HTML
gem 'haml', '~> 4.0.5'                          
# Use jQuery as the JavaScript library
gem 'jquery-rails', '~> 4.0.0.beta2'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease.
gem 'active_model_serializers', '~> 0.9'
# Bootstrap 3.0
gem 'bootstrap-sass', '~> 3.3.1.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.9'
# Building forms
gem 'simple_form', '~> 3.0.2'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development do
  # Automated deployment to production or staging environments
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-bundler', '~> 1.1.3'
  gem 'capistrano-rails', '~> 1.1.2'
  gem 'capistrano-rbenv', '~> 2.0.2'
end

group :development, :test do
  # Add table properties info to models and specs
  gem 'annotate', '~> 2.6.5'    
  # My gem for testing  
  gem 'page_right', '~> 0.5'
  # Web browser driver for testing JS
  gem 'selenium-webdriver', '~> 2.43.0' 
  # Testing DSL
  gem 'capybara', '~> 2.4.4'  
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0.0.beta4'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Gem for mocking and stubbing
  gem 'mocha', '~> 1.1.0'
  # Gem for testing Javascript
  gem 'jasmine', '~> 2.1.0'
  # Provides extensions to Jasmine for using JQuery and fixtures
  gem 'jasmine-jquery-rails', '~> 2.0.3'
  # Build records for testing
  gem 'factory_girl_rails', '~> 4.4.1'                                   # Test your return html with Capybara
  gem 'database_cleaner', github: 'bmabey/database_cleaner'    # Clean up the Test DB after testing
end