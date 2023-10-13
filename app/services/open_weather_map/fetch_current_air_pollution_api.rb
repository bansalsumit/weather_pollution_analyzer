module OpenWeatherMap
  class FetchCurrentAirPollutionApi < BaseService
    def initialize(params={})
      super
      @params = params
    end

    def call
      response = OpenWeatherMap::HttpRequest.get_response(AIR_POLLUTION_URL, 'get', @params, nil)
      response
    end
  end
end
