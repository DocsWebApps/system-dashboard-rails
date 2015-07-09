New Features to Add
-------------------
- Add SLA information plus a description of the system, change button to System Details
- Create a cyclic batch job to run at 1min intervals to archive all closed incidents over 24hrs old and remove the
  current request driven process.
- API Version 2 - fully functional API for controlling the Dashboard
- A module to work out automatically the layout given any number of systems and display it
- try and make the images avaiable via helper methods


Version 2.3.0 09/07/2015
------------------------
- Updated CHANGELOG and README - 09/07/2015
- Re-designed database.yml - 09/07/2015
- Cleanedup database.yml file - 08/07/2015
- Modify database.yml - 07/07/2015
- Cleaned up gem file - 07/07/2015
- Added the ruby racer gem - 06/07/2015
- Changed production db to proddb - 06/07/2015
- Updated database.yml production host to system-dashboard-pgdb - 06/07/2015
- V1 API Removed - 25/06/2015
- Added the momentjs library to format dates on the client - 25/06/2015
- Upgraded to rails 4.2.2 - 21/06/2015
- Ammended documentation - 19/06/2015

Version 2.2.0 19/06/2015
------------------------
- Added a new feature to automatically update itself every 30secs without a full page refresh - 17/06/2015
- Updated gem page_right to version 0.6 - 15/06/2015
- V1 API depricated - 14/06/2016
- Added Gem rack-mini-profiler - 19/05/2015
- Upgraded rails and ruby, 4.2.1 and 2.2.2 respectivley - 10/05/2015
- Upgrade to selenium-webdriver 2.45.0 - firefox 36 - 08/03/2015
- Minor correction for homepage image no-repeat - 22/02/2015
- Changes to incident details to and added viewport meta data in application.html - 19/02/2015

Version 2.1.0 19/02/2015
------------------------
- Added new pics and updated README v2.1 - 19/02/2015
- Design/presentation of homepage given a lift - 19/02/2015
- Changed config.serve_static_assets to config.serve_static_files in production.rb - 11/02/2015
- Upgraded to Ruby 2.2.0 - 6/02/2015
- Fixed issues with responsive layout and changed copyright date to be dynamic - 06/02/2015
- Minor change to navbar layout - 06/02/2015
- Changed menu layout  - 26/01/2015
- Changed sass files to scss only and changed config.serve_static_assets to config.serve_static_files - 26/01/2015
- Updated gems for master
- Changed downgrade to delete and fixed 2 integration test bugs - 7/01/2015
- Added gems for gonzo version and tested OK \o/ - 5/01/2015
- Found a subtle bug when using .css('overflow','hidden')) in the wrong place - 5/1/2015
- JS converted to CS - 4/1/2015
- Moved all the JS to home_page.js
- Upgrade to rails 4.2 plus additional JQuery - 22/12/2014

Version 2.0.0 22/12/2014
------------------------
- Version 2.0 beta
- Rename hp_ref to fault_ref - 18/12/2014
- Dropped comments table and :resolution and :title columns off incidents and incident_histories - 18/12/2014
- Updated UML class diagram - 18/12/2014
- Changes to the modal and updated features and tests - 18/12/2014
- Minor changes to navabar testcase - now tests before and after login - 18/12/2014
- Release candidate 2.0rc1 - 17/12/2014
- Responsive front page - 16/11/2014
- Edit form complete - basic app now works! 16/12/2014
- Create and Update forms complete - 15/12/2014
- JS namespaced - app working - 14/12/2014
- Interim commit to reorg JS
- Incident details modal finsihed(ish) - 11/12/2014
- Primitive modals are working for some elements - 11/12/2014
- Developing with SimpleModal - 8/12/2014
- Working version with leanModal - 5/11/2014
- Admin login modal completed using leanModal JQuery plugin - 50122014
- Draft HomePage completed - Single Page App - 04/12/2014
- System page and Title Page completed and responsive in IE8 - 3/12/2014
- System page and Title Page completed(ish) - 2/12/2014
- System page 3rd attempt - 01/12/2014
- System page 2nd attempt - 1/12/2014
- System page 1st attempt - 30/11/2014
- Upgraded to PageRight 0.5.2 - 24/11/2014
- Upgraded to PageRight 0.5
- Upgraded to page_right 0.4 - 20/11/2014
- Upgraded to ruby 2.1.5 and page_right 0.3
- Added new datafile
- Migrated app to Ruby 2.1.3
- Migrated app to Rails version 4.1.6
- Changed JSON systems response to include :id, :color and :message
- V2 API Development underway - System names and statuses via JSON
- Refactored the Systemdecorator class
- Added new incident decorator
- Added IncidentDecorator for admin views
- More but smaller changes to System and Incident due to POODR
- Major changes to System and Incident due to POODR
- Added order(date: :desc) to incident_list/incident_history_list in system_decorator.rb
- Updated version label in UML diagram to include System dashboard
- Addition of Heroku environment script

Version 1.0.0 03/09/2014
------------------------
- Version 1.0 complete 03/09/2014