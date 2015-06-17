Feature: Automatically update the Dashboard at 30sec intervals

  In order to stay up to date with the statuses of my important systems
  As a user of the dashboard
  I want the dashboard to automatically update its information every 30secs and then to display the new information without any manual intervention

  Since one of the functions of the dashboard is to be displayed upon a large screen, it needs to be able to update itself automatically by polling the backend server approximatley every 30secs.

Scenario: Check that the dashboard updates itself automatically

  When I view the dashboard
  And a status channge occurs to any of the systems displayed
  Then the dashboard should display that status change within 30secs displaying the new, corrected information

Integration Test: ./test/integration/browser/check_homepage_autoupdate_test.rb