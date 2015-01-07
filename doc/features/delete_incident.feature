Feature: Delete an open incident from the dashboard

	In order to delete open incidents that initialy get raised as a P1 or P2
	As an administrator of the Dashboard
	I want an option on the edit incidents page that when clicked deletes the open incident from the Incident table.
	
	We often get incidents that have their initial severity automatically set to P2. When these incidents are raised the support team/system manager will assess the impact of the problem and may then downgrade it to a P3 or P4. In this situation the incident should not be displayed on the dashboard at all. Only P1/P2's are stored on the dashboard.
	
Background: Assume the following data exists in the system

	We have a single system with an open P1/P2 running incident but no incidents in the last 24 hours
	We have a single user with the admin role and the user is logged on
	
Scenario: Check that I can delete the open incident from the 'Edit Exisitng Incident' page

	When I navigate to the 'Edit Existing Incident' page
	And I click on the 'Delete' option for the open incident
	Then I get redirected to the main page 
	And the system now displays a green smiley
	And a flash message indicating success or failure

	When I click on the "Incident Details" link
	Then I should not see the details of the incident on the incident details page.

Integration Test: ./test/integration/browser/check_incident_functions_test.rb 