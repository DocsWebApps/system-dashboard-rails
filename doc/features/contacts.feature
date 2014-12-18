Feature: View the details on the Dashboars contacts 

	In order to report bugs and extract more information reagding an incident
	As a Dashboard user
	I want to view contact details for those people who can perform the above activities.

	Basic contacts page for bug reporting and for more information

Background: Assume the following data exists in the system

	The system has a set of contact details it displays on the contacts page
	
Scenario: Check the details on the contacts page	

	When I navigate to the contacts page
	And the page title should be displayed 
	And the main section containing the contact deails should be displayed

Integration Test: ./test/integration/browser/check_homepage_contacts_test.rb 