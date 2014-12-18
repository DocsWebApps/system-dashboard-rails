Feature: View incident details

	In order to view all incidents for a particular system
	As a dashboard user
	I want an information page to display details about this systems incidents

Background: Assume the following data exists in the system

	We have a single system on the dashboard
	There is an P1/P2 incident running now
	There is a P1/P2 incident closed more than 24 hours ago

Scenario: Check that the incident details page displays the right information in the right section

	When I navigate to the incident details section of this system
	Then the name of the system should be displayed
	And the smiley on the page should be amber
	And 'Incidents Occuring in the last 24 hours' should be displayed
	And one incident should be displayed in the incident-details section
	And 'Chronological List of Historic Incidents' should be displayed
	And one incident should be displayed in the incident-history section	

Integration Test: ./test/integration/browser/check_incident_details_test.rb