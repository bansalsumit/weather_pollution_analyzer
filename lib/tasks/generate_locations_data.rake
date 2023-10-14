require 'csv'

namespace :location do
  desc 'Generate cities data'
  task generate_cities: :environment do
    # Load cities csv file
    file_path = Rails.root.join('cities.csv')
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    errors = []
    # This loop iterates through each city row and store it to database
    csv.each do |row|
      begin
        # Fetch geocoordinate from open weather map api
        data = OpenWeatherMap::FetchGeocoordinateApi.call(row.to_h)
        location = Location.create!(lat: data['lat'], long: data['lon'], name: data['name'], state: data['state'])
      rescue => exception
        errors << [row, exception.message]
      end
    end
    # Write now errors come because of city, state mismatch for some cities
    print errors if errors.present?
  end
end
