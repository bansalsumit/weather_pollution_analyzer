# frozen_string_literal: true
require 'uri'
require 'net/http'
require 'rails_helper'

RSpec.describe OpenWeatherMap::FetchCurrentAirPollutionApi do
  describe 'fetch current air pollution api' do
    it 'Should fetch current air pollution data' do
      VCR.use_cassette("fetch_current_air_pollution_api") do
        uri = URI(AIR_POLLUTION_URL)
        params = {
          lat: '23.0216238',
          lon: '72.5797068'
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
