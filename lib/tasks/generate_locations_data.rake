require 'csv'

namespace :location do
  desc 'Generate cities data'
  task generate_cities: :environment do
    file_path = Rails.root.join('tmp/cities.csv')
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    errors = []
    csv.each do |row|
      begin
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
