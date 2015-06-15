require 'test_helper'

class API::V1::Test < ActionDispatch::IntegrationTest
  
  def setup
    role=FactoryGirl.create :role_with_users
    @user=role.users.first
    @system=FactoryGirl.create :system_with_incidents
    FactoryGirl.create :company
  end
  
  def teardown
    DatabaseCleaner.clean
  end
          
  test 'get csrf token from web server' do
    get_csrf_v1_token
  end
  
  test 'get a list of systems and statuses' do
    get_systems_list
  end
  
  test 'check access is refused when using a fake token' do
    get api_v1_get_new_token_path, {}, {'Accept'=>Mime::JSON, 'Authorization' => "Token token='fake'"}
    assert_equal 401, response.status
    assert_equal 'Invalid Token', response.body 
  end
  
  private
    def get_systems_list
      decorator=SystemDecorator.new @system
      color,message=decorator.set_message_and_message_color
      get api_v1_systems_path, {}, {'Accept'=>Mime::JSON, 'Authorization'=>"Token token=#{@user.auth_token}"}
      assert_equal 200, response.status
      assert_equal "{\"systems\":[{\"id\":#{@system.id},\"name\":\"#{@system.name}\",\"status\":\"#{@system.status}\",\"color\":\"#{color}\",\"message\":\"#{message}\"}]}", response.body
      response.body
    end
    
    def get_csrf_v1_token
      get api_v1_get_new_token_path, {}, {'Accept'=>Mime::JSON, 'Authorization' => "Token token=#{@user.auth_token}"}
      assert_equal 200, response.status
      response.body
    end
  
end