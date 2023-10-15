# Weather Pollution Analyzer
A rails application to fetch, import, and store air pollution data for different cities across India.

## Technologies

* Ruby 3.2.2

* Rails 7.0.4

## Table of contents
* [Weather Pollution Analyzer](#weather-pollution-analyzer)
* [Technologies](#technologies)
* [Setup System](#setup-system)
* [System dependencies](#system-dependencies)
* [Abbrevations](#abbrevations)
* [Setup Demo Data](#setup-demo-data)
* [Features](#features)
* [Background jobs](#background-jobs)
* [Queries Example](#queries-example)
* [Rspec test cases](#rspec-test-cases)
* [Other information](#other-information)

## Setup System
To run this project:

```
$ git clone git@github.com:bansalsumit/weather_pollution_analyzer.git
$ cd ./weather_pollution_analyzer
$ rvm install 3.2.2
$ bundle install
```

## System dependencies
* Need postgres intalled
* Need redis installed
* Get master key from admin to access credentials

## Abbrevations
Check all the abbrevations used in code at abbrevations file in root path.

## Setup Demo Data
* To generate locations: `bundle exec rake location:generate_cities`
* To generate air pollution data: `bundle exec rake air_quality_metrics:import_current_air_pollution`
* To generate air pollution history data: `bundle exec rake air_quality_metrics:import_air_pollution_hostory`
## Features

## Background jobs
* Sidekiq used
* To execute jobs: `bundle exec sidekiq`

## Queries Example
* In rails console, execute below commands:
* aqi: air quality index
* Evaluate air quality for first object in rails console:
```
air_quality_metric = AirQualityMetric.first
air_quality_metric.assess_air_quality
```
* for getting average aqi per location: `Location.average_aqi_per_location`
* for getting average aqi particular location: `Location.average_aqi_per_location('delh')`
* for getting average aqi per state: `Location.average_aqi_per_state`
* for getting average aqi particular state: `Location.average_aqi_per_state('west')`
* for getting average aqi per month per location: `Location.average_aqi_per_state`
* for getting average aqi particular month per location: `Location.average_aqi_per_month_per_location(start_date: 2.months.ago, end_date: 1.months.ago)`

## Rspec test cases
* to execute rspec test suites: `bundle exec rspec`

## Other information
* Author - Sumit Bansal
* Github - https://github.com/bansalsumit
