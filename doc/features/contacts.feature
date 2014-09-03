Feature: View the details on the Dashboars contacts 

	In order to report bugs and extract more information reagding an incident
	As a Dashboard user
	I want to view contact details for those people who can perform the above activities.

	Basic contacts page for bug reporting and for more information

Background: Assume the following data exists in the system

	The system has a set of contact details it displays on the contacts page
	
Scenario: Check the details on the contacts page	

	When I navigate to the contacts page
	
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
	And the main section containing the contact deails should be displayed

Integration Test: ./test/integration/browser/contacts_test.rb 