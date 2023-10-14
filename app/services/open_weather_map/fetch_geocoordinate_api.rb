# frozen_string_literal: true

module OpenWeatherMap
  class FetchGeocoordinateApi < BaseService
    def initialize(params={})
      super
      @params = params
    end

    def call
      api_params = encode_for_api(@params)
      response = OpenWeatherMap::HttpRequest.get_response(GEOCODE_URL, 'get', api_params, nil)
      response&.first
    end

    private

    def encode_for_api(data)
      { q: data.values.join(',') }
    end
  end
end
