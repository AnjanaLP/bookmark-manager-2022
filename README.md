# Bookmark Manager

This is a Bookmark Manager application which has been developed using the BDD cycle and a test driven approach to fulfil the user stories below.

The app has been built using a Sinatra MVC framework with RESTful routing conventions. An ORM library has not been used in order to gain a deeper understanding of how OOP code interacts with relational databases and to practice writing raw SQL. SQL commands requiring user input have been protected against SQL injection. The pg gem has been used for communication between the ruby code and the databases, with one database for development and another for testing. Feature tests have been written using Capybara and unit tests in raw RSpec. A script has been written to clean the test database between tests to ensure accuracy. Test coverage is 100%. The connection to the database has been extracted into its own class to separate application behaviour from database behaviour. A setup script runs when the application boots, which sets up the connection with the correct database for the environment.

A one-to-many relationship has been implemented between bookmarks and comments, a many-to-many relationship between bookmarks and tags. A registration and authentication system has also been built from scratch (with the help of bcrypt to ensure only hashed passwords are stored in the database.)

## User stories
```
As a time-pressed user
So that I can quickly go to web sites I regularly visit
I would like to see a list of bookmarks

As a time-pressed user
So that I can save a website
I would like to add the site's address and title to bookmark manager

As a time-pressed user
So that I can remove a website I no longer visit
I would like to delete a bookmark from bookmark manager

As a time-pressed user
So that I can keep my bookmark information up-to-date
I would like to update a bookmark

As a time-pressed user
So that the bookmarks I save are useful
I would like to only save valid URLs

As a time-pressed user
So that I can note my opinions about a bookmark
I would like to add comments to a bookmark

As a time-pressed user
So that I can categorise my bookmarks
I would like to add tags to a bookmark   

As a time-pressed user
So that I can find relevant bookmarks
I would like to filter bookmarks by a tag

As a time-pressed user
So that I can have a personalised bookmark manager
I would like to sign up with my email address

As a time-pressed user
So that I can have a secure account
I would like to sign in with my email address and password

As a time-pressed user
So that I can keep my account secure while offline
I would like to sign out
```

## How to use

### Install project dependencies
Clone the repo to your local machine, change into the directory, then:
```
$ bundle install
```

### Setup the databases
You will need to have the PostgreSQL database management system installed to proceed.
```
$ rake setup
```
You will now have two databases: `bookmark_manager` for the development environment, and `bookmark_manager_test` for the test environment.
Both databases will have the tables needed to run the application.

### Run the app
```
$ rackup
```
Visit http://localhost:9292

### Run tests
```
rspec
```

### Technologies used
* CSS
* Capybara
* HTML
* PostgreSQL
* Ruby
* RSpec
* Sinatra
* SQL
