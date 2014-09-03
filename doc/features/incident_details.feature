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

	Then in the nav bar the following <links> should be <visible>
	Examples:
	| links 					| visible 	|
	| View Dashboard			| yes		|
	| Contacts	 				| yes		|
	| Tell Us?					| yes		|
	| Admin Login				| yes		|
	| Create New Incident		| no		|
	| Edit Existing Incident	| no	 	|

	And the page title-section should be displayed 
	And the name of the system should be displayed
	And the smiley on the page should be amber
	And 'Show Incident History' check box should be displayed
	And 'Recent Incidents for #{System}' should be displayed
	And one incident should be displayed in the incident-details section
	And 'Historic Incidents for #{System}' should be displayed
	And one incident should be displayed in the incident-history section	

Integration Test: ./test/integration/browser/incident_details_test.rb
