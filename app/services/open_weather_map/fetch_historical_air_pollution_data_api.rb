# frozen_string_literal: true

module OpenWeatherMap
  class FetchHistoricalAirPollutionDataApi < BaseService
    def initialize(params={})
      super
      @params = params
    end

    def call
      response = OpenWeatherMap::HttpRequest.get_response(AIR_POLLUTION_HISTORY_URL, 'get', @params, nil)
      response
    end
  end
end
