# frozen_string_literal: true

namespace :air_quality_metrics do
  desc 'Import air quality metrics data'
  task import: :environment do
    # Load locations in batch of 1000
    errors = []
    Location.find_each do |location|
      params = {
        lat: location.lat,
        lon: location.long
      }
      begin
        # Fetch current air pollution data from open weather map api
        data = OpenWeatherMap::FetchCurrentAirPollutionApi.call(params)
        if data.present?
          air_quality_metric = AirQualityMetric.new(data.dig('list').first.dig('components'))
          air_quality_metric.location = location
          air_quality_metric.aqi = data.dig('list').first.dig('main', 'aqi')
          air_quality_metric.save!
        else
          # Raise exception when issue in fetching data
          raise 'having trouble in fetching data from fetch_current_pollution_api.'
        end
      rescue => exception
        errors << [row, exception.message]
      end
      # NOTE: print the errors
      print errors if errors.present?
    end
  end
end
