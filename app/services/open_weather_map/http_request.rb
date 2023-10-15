# frozen_string_literal: true
require 'uri'
require 'net/http'

module OpenWeatherMap
  class HttpRequest
    # TODO: Need changes to handle POST request
    def self.get_response(url, method, params, api_log_object)
      uri = URI(url)
      params[:appid] = Rails.application.credentials.open_weather_map[:appid]
      params[:limit] = PER_PAGE_LIMIT
      uri.query = URI.encode_www_form( params )
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      JSON.parse(response.body)
    end
  end
end
