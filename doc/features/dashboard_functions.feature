Feature: Check the dashboard functions correctly

	In order to get the right status/history information from the Dashboard
	As a user of the Dashboard
	I want the statuses and indicators for the various systems to automatically update on each view according to the rules set out below
	
		1. If no Open P1 or P2 incidents are currently running on the system, the status should show a green smiley
		
		2. If a P1 incident(s) is(are) currently running on a system, its status should show a red smiley and details of the incident should be displayed on the incident details page in the current incidents section.
		
		3. If a P2 incident(s) is(are) currently running on a system, its status should show an amber smiley and details of the incident should be displayed on the incident details page in the current incidents section.

		4. If both a P1(s) and a P2(s) incident(s) is(are) currently running on a system, its status should show a red smiley and details of all P1/P2 incidents should be displayed in the incident details page in the current incidents section.
		
		5. If a system has had an Open P1 or P2 incident(s) in the last 24 hours, which is(are) now closed, its status should show a green smiley and its indicator should display either 'X Incident(s) in the last 24 hours' in red, where 'X' is the number of incidents in the last 24 hours. The details of the incident should be visible on the incident details page in the current incidents section with a status of 'Closed'.
		
		6. If any system has had no Open P1 or P2 incidents in the last 24 hours its indicator should show; 

		EITHER
		'X Days since the last incident', where 'X' is the number of days from the last incident recorded in the system 
		OR 
		'No previous incidents recorded yet', if there are no incidents for this system recorded in the database. 

		Both should be displayed in green.
		
		7. All closed incidents over 24 hours old should be visible in the historic incidents section on the incident details page.

Background: Assume the following data exists in the system

	We have four systems listed in the dashboard; kirk, spock, sulu and bones
	kirk has no P1/P2 incidents running, spock has a P2 incident running now, but has no other incidents recorded in the database. Bones has no P1/P2 incidents running now but had a P1 in the last 24 hours that is closed and no other incidents recorded in the database. Sulu has a P1 running now, none in the last 24 hours, but it has an old closed incident 4 days old

Scenario: Check that the contents of the page refelct the background data above

	When I go to the dashboard home page
	Then I should see the title on the page
	And I should see the status key on the page	
	
	And I should see the following in the main-section
	| system 	| smiley colour | indicator message 								|
	| kirk 		| green 				| No previous incidents recorded yet|
	| spock 	| amber 				| No previous incidents recorded yet|
	| bones 	| green 				| 1 Incident in the last 24 hours		|
	| sulu 		| red 					| 4 Days since the last incident 		|

	And I should see 'Incident Details'
	And I should see the 'Page last refreshed:' message at the bottom of the page		

Integration Test: ./test/integration/browser/check_homepage_dashboard_test.rb 