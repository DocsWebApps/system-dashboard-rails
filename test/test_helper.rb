ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/pride'

Capybara.default_driver = :rack_test


class ActionDispatch::IntegrationTest
  include Capybara::DSL
  self.use_transactional_fixtures=false
  DatabaseCleaner.strategy = :truncation
end

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  self.use_transactional_fixtures=true
  
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def create_user_for_login_tests
    @email='admin@admin.com'
    @password='thisisatest'
    role=FactoryGirl.create :role
    role.users.create name: 'Test', email: @email, password: @password, password_confirmation: @password
  end
  
  def set_string(size)
    test_string='a'
    (size-1).times {test_string+='a'}
    test_string
  end

  def check_system_section(name, indicator, smiley)
    image_in_section "##{name}", smiley, 1
    text_in_section "##{name}", indicator
    text_in_section "##{name}", name
    text_in_section "##{name}", "Incident Details"    
  end
  
  def json(body)
    JSON.parse(body, symbolize_names: true)
  end
end
