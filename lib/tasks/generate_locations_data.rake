# frozen_string_literal: true
require 'csv'

namespace :location do
  desc 'Generate cities data'
  task generate_cities: :environment do
    # Get the logger for the current class or module
    logger = Rails.logger
    logger.info "Processing the import cities geocoordinates data request start.........."

    # Load cities csv file
    file_path = Rails.root.join('cities.csv')
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)

    processed_cities = []
    errors = []

    # This loop iterates through each city row and store it to database
    csv.each do |row|
      # Skip loop if coordinates already stored.
      next if Location.where('name ilike ?', row['city']).exists?

      begin
        # Fetch geocoordinate from open weather map api
        data = OpenWeatherMap::FetchGeocoordinateApi.call(row.to_h)

        location = Location.create!(lat: data['lat'], long: data['lon'], name: data['name'], state: data['state'])
        processed_cities << row['city']
      rescue => exception
        errors << [row, exception.message]
      end
    end

    logger.info "processed cities #{processed_cities}"
    if errors.present?
      logger.error('Errors occurred during city data generation:')
      errors.each do |error|
        logger.error("Row: #{error[0]}, Error: #{error[1]}")
      end
      # Notify about errors to admin
      # FIXME: It need some change
      AdminMailer.error_notification('Error Notification for City Data Generation', errors).deliver_now
    end
    logger.info "Processing the import cities geocoordinates data request closed.........."
  end
end
