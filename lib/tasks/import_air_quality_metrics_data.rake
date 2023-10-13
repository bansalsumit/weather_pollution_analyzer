namespace :air_quality_metrics do
  desc 'Import air quality metrics data'
  task import: :environment do
    Location.find_each do |location|
      params = {
        lat: location.lat,
        lon: location.long
      }
      data = OpenWeatherMap::FetchCurrentAirPollutionApi.call(params)
      if data.present?
        air_quality_metric = AirQualityMetric.new(data.dig('list').first.dig('components'))
        air_quality_metric.location = location
        air_quality_metric.aqi = data.dig('list').first.dig('main', 'aqi')
        air_quality_metric.save
      end
    end
  end
end
