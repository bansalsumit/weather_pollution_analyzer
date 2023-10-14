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
* To generate air pollution data: `bundle exec rake air_quality_metrics:import`

## Features


## Other information
* Author - Sumit Bansal
* Github - https://github.com/bansalsumit
