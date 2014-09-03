Feature: Edit the details of an existing incident already in the system

	In order to update an existing incident should the situation surrounding it change
	As an administrator of the Dashboard
	I want a form on a screen to enable me to manually edit the information regarding an existing incident and save that information
	
	When an incident occurs, as time progresses the situation can change. Incidents can be escalated or downgraded, new information can be made available. Sometimes, this new information needs to be entered into the Dashboard for other people to view.

Background: Assume the following data exists in the system

	We have a single system with a P2 running incident but no incidents in the last 24 hours
	We have a single user with the admin role and the user is logged on

Scenario: Check that we can escalate the severity of a P2 incident to P1 sand save the change

	When I navigate to the 'Edit Existing Incident' page
	And I click 'Update'
	Then I get presented with a form containing the existing incident data

	When I choose 'P1' and click 'Update Incident'
	Then I get redirected to the main page
	And the system now displays a red smiley

Integration Test: ./test/integration/browser/incident_functions_test.rb - 'Test all the functions related to managing incidents'