Feature: Downgrade an incident from a P1 or P2

	In order to downgrade incidents that initialy get raised as a P1 or P2
	As an administrator of the Dashboard
	I want an option on the edit incidents page that when clicked moves the incident from the Incident table to the IncidentHistory table and modifies the severity to "D"
	
	We often get incidents that have their initial severity automatically set to P2. When these incidents are raised the support team/system manager will assess the impact of the problem and may then downgrade it to a P3 or P4. In this situation the incident should not be reflected as a geniune P2 on the dashboard, but it still needs to be recorded in the history with
	a severity other than P2. In this case, we'll use "D" instead for "Downgraded". 
	
Background: Assume the following data exists in the system

	We have a single system with a P1/P2 running incident but no incidents in the last 24 hours
	We have a single user with the admin role and the user is logged on
	
Scenario: Check that I can downgrade the incident from the 'Edit Exisitng Incident' page

	When I navigate to the 'Edit Existing Incident' page
	And I click on the 'Downgrade' option for the open incident
	Then I get redirected to the main page 
	And the system now displays a green smiley
	And a flash message indicating success or failure

	When I click on the "Incident Details" link
	Then I should not see the details of the incident in the incident details section
	And I should see the details of the incident with a serverity of 'D' and a status of 'Closed'

Integration Test: ./test/integration/browser/check_incident_functions_test.rb 