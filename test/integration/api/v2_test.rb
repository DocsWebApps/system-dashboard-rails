require 'test_helper'

class API::V2::Test < ActionDispatch::IntegrationTest
  
  def setup
    role=FactoryGirl.create :role_with_users
    @user=role.users.first
    @system=FactoryGirl.create :system_with_incidents
    FactoryGirl.create :company
  end
  
  def teardown
    DatabaseCleaner.clean
  end
          
  test 'get a list of incidents for a system' do
    system_list=json(get_systems_list)
    system_list.each do |system|
      get api_v2_system_incidents_path(system[:name]), {}, {'Accept'=>Mime::JSON, 'Authorization'=>"Token token=#{@user.auth_token}"}
      assert_equal response.status, 200
    end
  end
          
  test 'get csrf token from web server' do
    get_csrf_v2_token
  end
  
  test 'get a list of systems and statuses' do
    get_systems_list
  end
  
  test 'check access is refused when using a fake token' do
    get api_v2_get_new_token_path, {}, {'Accept'=>Mime::JSON, 'Authorization' => "Token token='fake'"}
    assert_equal response.status, 401
    assert_equal response.body, 'Invalid Token'
  end
  
  private
    def get_systems_list
      get api_v2_systems_path, {}, {'Accept'=>Mime::JSON, 'Authorization'=>"Token token=#{@user.auth_token}"}
      assert_equal response.status, 200
      assert_equal response.body, System.select(:name, :status).to_json(only: [:name, :status])
      response.body
    end
    
    def get_csrf_v2_token
      get api_v2_get_new_token_path, {}, {'Accept'=>Mime::JSON, 'Authorization' => "Token token=#{@user.auth_token}"}
      assert_equal response.status, 200
      response.body
    end
  
end