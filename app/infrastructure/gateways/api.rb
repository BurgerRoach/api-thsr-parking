# frozen_string_literal: true

require 'http'

module THSRParking
  module THSR
    # Library for THSR API
    class Api
      def search
        Request.new.get
      end

      # def search_by_city(city, options = {})
      #   # @params city {string} city name
      #   # @params options {hash}
      #   # @return {array-hash} the response data after filtered by city name
      #   filtered_data = Request.new.get
      #   THSR::City.new(filtered_data, city).get
      #   # JSON.parse(THSR::City.new(filtered_data, city).get.to_h.to_json)
      # end

      # def search_by_park_id(park_id, options = {})
      #   # @params park_id {int} city name
      #   # @params options {hash}
      #   # @return {hash} the response data after filtered by park id
      #   filtered_data = Request.new.get
      #   THSR::Park.new(filtered_data, park_id).get
      #   # JSON.parse(THSR::Park.new(filtered_data, park_id).get.to_h.to_json)
      # end

      # Request
      class Request
        API_URL = 'https://traffic.transportdata.tw/MOTC/v1/Parking/OffStreet/ParkingAvailability/Rail/THSR?$format=JSON'

        def get
          http_response = HTTP.get(API_URL)

          Response.new(http_response).tap do |response|
            raise(response.error) unless response.http_error?
          end
        end
      end
      # Response SimpleDelegator
      class Response < SimpleDelegator
        include Errors
        HTTP_ERROR = {
          400 => Errors::BadRequest,
          401 => Errors::Unauthorized,
          404 => Errors::NotFound
        }.freeze

        def http_error?
          HTTP_ERROR.keys.include?(code) ? false : true
        end

        def error
          HTTP_ERROR[code]
        end
      end

      private

      # def call_api
      #   uri = URI(API_URL)
      #   response = Net::HTTP.get_response(uri)
      #   http_error?(response.code) ? JSON.parse(response.body) : raise(HTTP_ERROR[response.code])
      # end

      # def http_error?(status_code)
      #   HTTP_ERROR.keys.include?(status_code) ? false : true
      # end
    end
  end
end
