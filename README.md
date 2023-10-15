# Weather Pollution Analyzer
A rails application for Importing and Analyzing Air Pollution Data for different cities across India.

## Technologies

* Ruby 3.2.2

* Rails 7.0.4

* PostgreSQL

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
* [External API References](#external-api-references)
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
Check all the abbrevations used in code at **abbrevations** file in root path.

## Setup Demo Data
* First Ensure **cities.csv** file should be present in root folder
* To generate locations: `bundle exec rake location:generate_cities`
* To generate air pollution data: `bundle exec rake air_quality_metrics:import_current_air_pollution`
* To generate air pollution history data: `bundle exec rake air_quality_metrics:import_air_pollution_hostory`

## Features
* Able to fetch Geocoordinates, Current Air Polltuin Data and Air Polltuin History per location from open weather map API.
* Able to run Current Air Polltuion Data in background.
* Able to do Analytics like: access air quality, average air quality index by city, state and date combination.
* Used test suites to increase Quality and Reliability of software.

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

## External API References

The following external APIs were used in this project to fetch pollution data:

- [OpenWeatherMap API](https://openweathermap.org/api): Used to retrieve current air pollution, air pollution history, geocoordinate-related data.

  - **How it was used:** The OpenWeatherMap API was integrated to obtain air compositions, including SO2, O3, and NO2 etc.

  - **API Key:** To obtain API key use: https://home.openweathermap.org/api_keys

## Other information
* Author - Sumit Bansal
* Github - https://github.com/bansalsumit
