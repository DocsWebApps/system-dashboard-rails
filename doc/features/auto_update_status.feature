Feature: Automatically update the status of the systems at 1min intervals

  In order to stay upto date with the statuses of my important systems
  As a user of the dashboard
  I want the dashboard to automatically update its information every minute and then to display that information without any manual intervention

  Since one of the functions of the dashboard is to be displayed upon a large screen, it needs to be able to update itself automatically by polling the backend server approximatley once a minute.

Scenario: Check that the dashboard updates itself automatically

  When I view the dashboard
  And a status channge occurs to any of the systems displayed
  Then the dashboard should display that change within a minute with all the correct information

Integration Test: ./test/integration/browser/check_homepage_autoupdate_test.rb