Feature: Close an open incident

	In order to close an open incident
	As an administrator of the Dashboard
	I want an option on the edit incidents page that when clicked closes the incident
	
	Once an incident has been raised we tend to work on that incident until we have either fixed it or we have a work around. Although problem management and RCA investigations may continue, once service is restored we consider the incident closed. At this point we will need to close the incident from the 'Edit Exisitng Incident' page.

Background: Assume the following data exists in the system

	We have a single system with a P1/P2 running incident but no incidents in the last 24 hours
	We have a single user with the admin role and the user is logged on
	
Scenario: Check that I can close the incident from the 'Edit Exisitng Incident' page

	When I navigate to the 'Edit Existing Incident' page
	And I click on the 'Close' option for the open incident
	Then I get redirected to the main page 
	And the system now displays a green smiley

	When I click on the "More Information" link
	Then I should see the details of the incident with a status of 'Closed'

Integration Test: ./test/integration/browser/incident_functions_test.rb - 'Test all the functions related to managing incidents'