# frozen_string_literal: true
require 'uri'
require 'net/http'
require 'rails_helper'

RSpec.describe OpenWeatherMap::FetchCurrentAirPollutionApi do
  describe 'fetch current air pollution api' do
    it 'Should get 200 response status' do
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

    it 'Should fetch all components which cause air pollution' do
      VCR.use_cassette("fetch_current_air_pollution_api") do
        uri = URI(AIR_POLLUTION_URL)
        params = {
          lat: '23.0216238',
          lon: '72.5797068'
        }
        expected_pollution_causing_components = ["co", "no", "no2", "o3", "so2", "pm2_5", "pm10", "nh3"]
        params[:appid] = Rails.application.credentials.open_weather_map[:appid]
        params[:limit] = PER_PAGE_LIMIT
        uri.query = URI.encode_www_form( params )
        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Get.new(uri.request_uri)
        response = http.request(request)

        data = JSON.parse(response.body)
        pollution_causing_components_in_response = data['list'].first['components'].keys
        expect(pollution_causing_components_in_response).to eq(expected_pollution_causing_components)
      end
    end
  end
end
