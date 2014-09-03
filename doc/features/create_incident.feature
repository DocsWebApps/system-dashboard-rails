Feature: Create a new incident

	In order to manually enter the details of a new incident on the System Dashboard
	As an administrator of the Dashboard
	I want an input form on a screen thats accessible only as an administrator to allow me to enter the following fields

		System: A dropdown listing all the systems I can enter incident information for
		Description: a description of the incident
		Severity: The severity of the incident, P1 or P2
		HP_REF: The HP reference number of the incident
		Date: The date of the incident
		Time: The time of the incident
		
	This is a basic input form to manually enter the details of an incident

Background: Assume the following data exists in the system

	We have a single user with the admin role and the user is logged on
	
Scenario: Create a new incident via the 'Create New Incident' page

	When I navigate to the 'Create New Incident' page
	And I enter the system name, description, severity (P2), hp_ref, date and time and click 'Create Incident'
	Then I get redirected to the main page and the system is showing an amber smiley

Integration Test: ./test/integration/browser/incident_functions_test.rb - 'Test all the functions related to managing incidents'