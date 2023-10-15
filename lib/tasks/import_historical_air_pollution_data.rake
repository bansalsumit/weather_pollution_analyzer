# frozen_string_literal: true

require_relative '../../app/helpers/date_helper.rb'

namespace :air_quality_metrics do
  # Macros
  include DateHelper

  desc 'Import historical air pollution data'
  task import_air_pollution_hostory: :environment do
    # Load locations in batch of 1000
    errors = []
    start_date = 1.years.ago
    end_date = start_date + 3.hours
    Location.find_each do |location|
      params = {
        lat: location.lat,
        lon: location.long,
        start: start_date.to_i,
        end: end_date.to_i
      }

      begin
        # Fetch air pollution history for given location from open weather map api
        data = OpenWeatherMap::FetchHistoricalAirPollutionDataApi.call(params)
        if data.present?
          data['list'].each do |air_pollution_data|
            air_quality_metric = AirQualityMetric.new(air_pollution_data.dig('components'))
            air_quality_metric.location = location
            air_quality_metric.aqi = air_pollution_data.dig('main', 'aqi')
            air_quality_metric.dt = convert_unix_timestamp_to_date_time(air_pollution_data.dig('dt'))
            air_quality_metric.save!
          end
        else
          # Raise exception when issue in fetching data
          raise 'having trouble in fetching data from fetch_current_pollution_api.'
        end
      rescue => exception
        errors << [location.name, exception.message]
      end
      start_date += 1.months
      end_date = start_date + 3.hours
    end
    # NOTE: print the errors
    print errors if errors.present?
  end
end
