# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Ruby version: 3.2.2

System dependencies
need postgres intalled

Initial commands
git clone git@github.com:bansalsumit/weather_pollution_analyzer.git
cd ./weather_pollution_analyzer
bundle install

Abbrevations
Check all the abbrevations used in code at abbrevations file.

First Load cities data like lat, long by executing below command
Add cities.csv file in tmp directory
bundle exec rake location:generate_cities
