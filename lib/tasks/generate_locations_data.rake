require 'csv'

namespace :location do
  desc "Generate cities data"
  task generate_cities: :environment do
    file_path = Rails.root.join('tmp'+'/cities.csv')
    csv_text = File.read(file_path)
    csv = CSV.parse(csv_text, :headers => true)
    errors = []
    csv.first(5).each do |row|
      begin
        data = OpenWeatherMap::FetchGeocoordinateApi.call(row.to_h)
        location = Location.create!(lat: data['lat'], long: data['lon'], name: data['name'])
      rescue => exception
        errors << [row, exception.message]
      end
    end
    print errors
  end
end
