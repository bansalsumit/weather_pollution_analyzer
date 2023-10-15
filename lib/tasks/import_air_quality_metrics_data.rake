# frozen_string_literal: true
require_relative '../../app/helpers/date_helper.rb'

namespace :air_quality_metrics do
  # Macros
  include DateHelper

  desc 'Import air quality metrics data'
  task import_current_air_pollution: :environment do
    # Get the logger for the current class or module
    logger = Rails.logger

    logger.info "Processing the import air quality metrics data request start.........."
    errors = []

    # Iterate on locations, Load locations in batch of 1000
    Location.find_each do |location|
      params = {
        lat: location.lat,
        lon: location.long
      }
      begin
        # Fetch current air pollution data from open weather map api
        data = OpenWeatherMap::FetchCurrentAirPollutionApi.call(params)
        if data.present?
          # Create Air Quality Metric
          air_quality_metric = AirQualityMetric.new(data.dig('list').first.dig('components'))
          air_quality_metric.location = location
          air_quality_metric.aqi = data.dig('list').first.dig('main', 'aqi')
          air_quality_metric.dt = convert_unix_timestamp_to_date_time(data.dig('list').first.dig('dt'))
          air_quality_metric.save!
        else
          # Raise exception when issue in fetching data
          raise 'having trouble in fetching data from fetch_current_pollution_api.'
        end
      rescue => exception
        errors << [location.name, exception.message]
      end
    end

    if errors.present?
      logger.error('Errors occurred during city data generation:')
      errors.each do |error|
        logger.error("City: #{error[0]}, Error: #{error[1]}")
      end
      # Notify about errors to admin
      # FIXME: It need some change
      AdminMailer.error_notification('Error Notification for Air Quality Metric Data Generation', errors).deliver_now
    end
    logger.info "Processing the import air quality metrics data request closed.........."
  end
end
