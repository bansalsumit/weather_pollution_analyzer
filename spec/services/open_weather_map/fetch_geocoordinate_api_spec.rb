# frozen_string_literal: true
require 'uri'
require 'net/http'
require 'rails_helper'

RSpec.describe OpenWeatherMap::FetchGeocoordinateApi do
  describe 'fetch coordinates api' do
    it 'Should fetch coordinates' do
      VCR.use_cassette("fetch_geocoordinate_api") do
        uri = URI(GEOCODE_URL)
        data = {
          city: 'Mumbai',
          state: 'Maharashtra',
          country: 'IN'
        }
        params = { q: data.values.join(',') }
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
