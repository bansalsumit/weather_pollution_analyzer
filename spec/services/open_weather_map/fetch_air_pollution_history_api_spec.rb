# frozen_string_literal: true
require 'uri'
require 'net/http'
require 'rails_helper'

RSpec.describe OpenWeatherMap::FetchHistoricalAirPollutionDataApi do
  describe 'fetch air pollution history api' do
    it 'Should fetch air pollution history' do
      VCR.use_cassette('fetch_air_pollution_history_api') do
        uri = URI(AIR_POLLUTION_HISTORY_URL)
        params = {
          lat: '23.0216238',
          lon: '72.5797068',
          start: '1694688196',
          end: '1694774600'
        }
        params[:appid] = Rails.application.credentials.open_weather_map[:appid]
        params[:limit] = PER_PAGE_LIMIT
        uri.query = URI.encode_www_form( params )
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        expect(response.code).to eq('200')
      end
    end
  end
end
