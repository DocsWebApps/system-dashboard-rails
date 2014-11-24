source 'https://rubygems.org'

ruby '2.1.5'

# Rails version
gem 'rails', '4.1.6'

# Postgresql database
gem 'pg','0.17.1'       

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby      # To run your javascript - can use Nodejs

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'     # Use jquery for the UI

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease.
gem 'active_model_serializers', '0.9'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# My Additional Gems
gem 'haml','4.0.5'                          # HTML shortcut
gem 'simple_form', '~>3.0.1'                # Forms shortcut

# *** DELETE THE GEMS BELOW PRIOR TO LOCAL PROD BUILD ***
# Gems for new relic monitoring
#gem 'newrelic_rpm'

group :development, :test do
  gem 'annotate', '2.5.0'                   # Add table properties info to models and specs
  gem 'railroady', '1.1.0'                  # Produces a schema of the DB objects
  gem 'factory_girl_rails', '~> 4.4.1'      # Build records for testing
end

group :test do
  gem 'page_right', '~> 0.5.2'
  gem 'selenium-webdriver', '2.43.0'         # Web driver for running JS
  gem 'shoulda', '~> 3.0'
  gem 'capybara'                              # Test your return html with Capybara
  gem 'database_cleaner', github: 'bmabey/database_cleaner'    # Clean up the Test DB after testing
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false    # Docs
end
