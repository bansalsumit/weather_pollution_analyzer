module OpenWeatherMap
  class FetchGeocoordinateApi < BaseService
    def initialize(params={})
      super
      @params = params
    end
    
    def call
      url = 'http://api.openweathermap.org/geo/1.0/direct'
      api_params = {q: @params.values.join(',')}
      response = OpenWeatherMap::HttpRequest.get_response(GEOCODE_URL, 'post', api_params, nil)
      response&.first
    end
  end
end
