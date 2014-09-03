Feature: Administrator Login

	In order to use the administrator features of this application
	As an administrator of the dashboard
	I want to login to the dashboard and have access to administrator features
	
	Basic login access for administrators of the Dashboard using an email for a username and a password.

Background: Assume the following data exists in the system

	We have a single system with no running incidents, no incidents in the last 24 hours and no historic incidents
	We have a single user with the admin role
	
Scenario: Check that you can login using the correct credentials

	When I go to the root path for the application
	Then I should see the system with a green smiley 
	And an indicator stating there were no previous incidents in the last 24 hours

	And in the nav bar the following <links> should be <visible>
	Examples:
	| links 					| visible 	|
	| View Dashboard			| yes		|
	| Contacts	 				| yes		|
	| Tell Us?					| yes		|
	| Admin Login				| yes		|
	| Create New Incident		| no		|
	| Edit Existing Incident	| no	 	|	

	Then I login into the Dashboard using the correct login credentials

	And in the nav bar the following <links> should be <visible>
	Examples:
	| links 					| visible 	|
	| View Dashboard			| yes		|
	| Contacts	 				| yes		|
	| Tell Us?					| yes		|
	| Admin Login				| no		|
	| Create New Incident		| yes		|
	| Edit Existing Incident	| yes	 	|	

Integration Test: ./test/integration/browser/incident_functions_test.rb - 'Test all the functions related to managing incidents'