require 'test_helper'

class API::V1::Test < ActionDispatch::IntegrationTest
  
  def setup
    role=FactoryGirl.create :role_with_users
    @user=role.users.first
    @system=FactoryGirl.create :system
    FactoryGirl.create :company
  end
  
  def teardown
    DatabaseCleaner.clean
  end
            
  test 'check access is refused when using a fake token' do
    get new_api_v1_incident_path, {}, {'Accept'=>Mime::JSON, 'Authorization' => "Token token='fake'"}
    assert_equal 401, response.status
    assert_equal 'Invalid Token', response.body 
  end
          
  test 'Closing existing incident - test for success' do
    create_new_incident
    incident=@system.incidents.first
    
    delete api_v1_incident_path(incident.hp_ref),
    {system: @system.name, query: 'close'}.to_json,
    {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'authenticity_token' => get_csrf_v1_token, 'Authorization' => "Token token=#{@user.auth_token}"}
    
    check_response('close_downgrade_OK', response, 201)
  end
  
  test 'Downgrade existing incident - test for success' do
    create_new_incident
    incident=@system.incidents.first
    
    delete api_v1_incident_path(incident.hp_ref),
    {system: @system.name, query: 'downgrade'}.to_json,
    {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'authenticity_token' => get_csrf_v1_token, 'Authorization' => "Token token=#{@user.auth_token}"}
    
    check_response('close_downgrade_OK', response, 201)  
  end
          
  test 'Update existing incident - test for success' do
    create_new_incident
    incident=@system.incidents.first
    
    patch api_v1_incident_path(incident.hp_ref),
    {system: @system.name, incident: {description: 'Test is now finsihed'}}.to_json, 
    {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'authenticity_token' => get_csrf_v1_token, 'Authorization' => "Token token=#{@user.auth_token}"}
    
    check_response('updateOK', response, 201)
  end
          
  test 'Create new incident using API - test for success' do
    # In this test all of the required params are sent in the post request
    create_new_incident
  end
  
  test 'Create new incident using API - test for failed' do
    # In this test not all of the required params are sent in the post request; severity: is missing   
    post api_v1_incidents_path, 
    {system: @system.name, incident: {description: 'Test', hp_ref: 'HP 123', time: '10:00', date: '01/01/2014', status: 'Open' }}.to_json, 
    {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'authenticity_token' => get_csrf_v1_token, 'Authorization' => "Token token=#{@user.auth_token}"}
    
    check_response('createBAD', response, 400)
  end
  
  private 
    def create_new_incident
      post api_v1_incidents_path, 
      {system: @system.name, incident: {description: 'Test', severity: 'P2', hp_ref: 'HP 123', time: '10:00', date: '01/01/2014', status: 'Open' }}.to_json, 
      {'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'authenticity_token' => get_csrf_v1_token, 'Authorization' => "Token token=#{@user.auth_token}"}
      
      check_response('createOK', response, 201)
    end
  
    def check_response(result, response, status)
      assert_equal status, response.status
      data=json(response.body)
      assert_equal result, data[:result]
    end
    
    def get_csrf_v1_token
      get new_api_v1_incident_path, {}, {'Accept'=>Mime::JSON, 'Authorization' => "Token token=#{@user.auth_token}"}
      assert_equal 200, response.status
      response.body
    end
 
end