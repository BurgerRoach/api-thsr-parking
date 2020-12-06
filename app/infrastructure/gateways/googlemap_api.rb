# frozen_string_literal: true

require 'net/http'
require 'json'

module THSRParking
  module GoogleMap
    # Library for Google Map API
    class Api
      def initialize(api_key)
        @api_key = api_key
      end

      def nearby_search(lat, lng, radius, type)
        # @params lat {string} latitude
        # @params lng {string} longtitude
        # @params radius {string} search radius
        # @params type {string} type of location e.g. restaurant
        Request.new(@api_key).nearby_search(lat, lng, radius, type)
      end

      class Request
        API_URL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json'

        def initialize(api_key)
          @api_key = api_key
        end

        def nearby_search(lat, lng, radius, type)
          api_url = join_parameters(lat, lng, radius, type)

          http_response = HTTP.get(api_url)
          Response.new(http_response).tap do |response|
            raise(response.error) unless response.http_error?
          end
        end

        def join_parameters(lat, lng, radius, type)
          "#{API_URL}?location=#{lat},#{lng}&radius=#{radius}&type=#{type}&key=#{@api_key}"
        end
      end

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
    end
  end
end
