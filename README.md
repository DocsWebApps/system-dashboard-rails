## Welcome to the System Dashboard

Version 2.3 3rd July 2015

The System Dashboard is a web application developed using Ruby on Rails that provides a visual dashboard to display the status's of your critical systems to your colleagues, senior managers and customers.

When an incident occurs on a particular system, you enter the details of the fault and the date and time it took place, you then choose a severity level and commit the information to the database. Any browser displaying the dashboard will then automatically update itself within 30 seconds to show the details of that incident to your user community. 

The status of your systems are colour coded to show whether the system is operating normaly (green), has a significant problem with it (yellow) or has a major problem with it (red). This means you can display the dashboard on a monitor or smart television mounted within your office space giving your user community a visual representation of the status of your key systems.

Users can then click on a link for that system to see the details of the incident, plus any details you choose to share with your users such as the details of any workarounds you want to convey to your user community or an estimated time to fix the fault.

It therefore provides a simple but effective way to keep your key stakeholders updated with any problems that your systems or services may be experiencing and what work is being undertaken to restore them.

An API is under development to enable web clients, like Android or IOS mobile applications, to interact with the Dashboard and the application has also been designed to be responsive to mobile devices. This means it will give your users a good viewing experience whether they are viewing the dashboard via a browser, tablet ot mobile phone.

Semantic versioning is applied to this application.

### Screenshots

Here are a few screenshots of the application.

<p><a href="https://drive.google.com/file/d/0B8ga1CuDRyBVR0ZvMjZ2TnZWd1k/view?usp=sharing" target="_blank">Homepage</a></p>
<p><a href="https://drive.google.com/file/d/0B8ga1CuDRyBVNXh4a2xqLTVYUVE/view?usp=sharing" target="_blank">Dashboard</a></p>
<p><a href="https://drive.google.com/file/d/0B8ga1CuDRyBVSnUxUkRpdGhXQ1E/view?usp=sharing" target="_blank">Incident Details</a></p>

### Installation

I will assume you already have an environment built to host a Rails application. If not then here is an excellent post describing the process (thanks to Chris Oliver for providing this).

<a href="http://gorails.com/deploy/ubuntu/14.04" target="_blank">Build a Rails production environment</a>

From your Rails production environment clone the Github System Dashboard repository.

```ruby
git clone https://github.com/DocsWebApps/system-dashboard-rails.git
```

Set up the following environment variables. In a production environment these will have to be set up so that they are visible from the Rails executables's perspective.

```ruby
export RAILS_ENV=production
export DASH_USER='** YOUR DB USERNAME **'
export DASH_PASS='** YOUR DB PASSWORD **'
export SECRET_KEY_BASE='** YOUR SECRET KEY **'
export ADMIN_KEY='** YOUR ADMIN KEY **'
```

Run bundle install to download the gems.

```ruby
bundle install
```

Load the database schema into your database.

```ruby
rake db:schema:load
```

Amend the data in the ./db/seed.rb file to reflect your systems and contact details. Then load the data into the database.

```ruby
rake db:seed
```

Compile the assets.

```ruby
rake assets:compile
```

Then simply configure your Ruby web server to point to the System Dashboard code and all should be well!

### License

System Dashboard is released under the <a href="http://www.opensource.org/licenses/MIT" target="_blank">MIT License</a>.