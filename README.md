# README

This README would normally document whatever steps are necessary to get the
application up and running.

* Ruby version: 2.5.3

* Database: PostgreSQL

* Database creation: rake db:setup

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions - Deployed to Heroku

* To run the rails server with https locally, use this command (and set up your self signed cert)
rails s -b 'ssl://localhost:3000?key=localhost.key&cert=localhost.crt'
* Chrome probably won't work with https, but Firefox will
* Also, uncomment the last line in development.rb 
* ...
