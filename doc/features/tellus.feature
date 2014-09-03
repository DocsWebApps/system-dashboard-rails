Feature: Collect feedback from users of the dashboard

	In order to annonymously provide feedback to the site
	As a user of the dashboard
	I want a form to enable me to enter feed back anonymously and save it to the database

Scenario: Check you can enter data into the dashboard anonymously

	When I navigate to the tellus page
	
	Then in the nav bar the following <links> should be <visible>
	Examples:
	| links 					| visible 	|
	| View Dashboard			| yes		|
	| Contacts	 				| yes		|
	| Tell Us?					| yes		|
	| Admin Login				| yes		|
	| Create New Incident		| no		|
	| Edit Existing Incident	| no	 	|	

	And the page title-section information should be displayed 
	And the main section containing the a form should be displayed
	
	When I enter some anonymous feedback into the form
	And I click 'Submit Feedback'
	Then I should see a message "Your feedback has been saved. Thank you for your time and input!"
	And the data I entered should be saved in the database

Integration Test: ./test/integration/browser/tellus_test.rb 