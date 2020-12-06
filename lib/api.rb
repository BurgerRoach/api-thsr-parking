# frozen_string_literal: true

require 'net/http'
require 'json'
require_relative 'base'
require_relative 'options'
require_relative 'errors'
require_relative 'city'
require_relative 'park'

module THSR
  # Library for THSR API
  class Api
    include Errors
    HTTP_ERROR = {
      400 => Errors::BadRequest,
      401 => Errors::Unauthorized,
      404 => Errors::NotFound
    }.freeze

    API_URL = 'https://traffic.transportdata.tw/MOTC/v1/Parking/OffStreet/ParkingAvailability/Rail/THSR?$format=JSON'

    def search(options = {})
      raise Errors::OptionsError if THSR::Options.new.invalid_options?(options)

      raw_data = call_api
      THSR::Base.new(raw_data, options).flatten
    end

    def search_by_city(city, options = {})
      # @params city {string} city name
      # @params options {hash}
      # @return {array-hash} the response data after filtered by city name
      filtered_data = search(options)
      THSR::City.new(filtered_data, city).get
    end

    def search_by_park_id(park_id, options = {})
      # @params park_id {int} city name
      # @params options {hash}
      # @return {hash} the response data after filtered by park id
      filtered_data = search(options)
      THSR::Park.new(park_id, filtered_data).get
    end

    private

    def call_api
      uri = URI(API_URL)
      response = Net::HTTP.get_response(uri)
      http_error?(response.code) ? JSON.parse(response.body) : raise(HTTP_ERROR[response.code])
    end

    def http_error?(status_code)
      HTTP_ERROR.keys.include?(status_code) ? false : true
    end
  end
end
