# frozen_string_literal: true

require 'http'

module THSRParking
  module THSRTime
    # Library for THSR API
    class Api
      def initialize(app_id, app_key)
        @app_id = app_id
        @app_key = app_key
      end

      def search(station_id, direction, date)
        Request.new(@app_id, @app_key).get(station_id, direction, date)
      end

      # Request
      class Request
        API_URL = 'https://ptx.transportdata.tw/MOTC/v2'

        def initialize(app_id, app_key)
          @app_id = app_id
          @app_key = app_key
          @current_timestamp = Time.now.utc.strftime('%a, %d %b %Y %T GMT')
        end

        def get(station_id=nil, direction, date)
          api_url = join_parameters(station_id, direction, date)
          authorization_header = set_authorization_header

          http_response = HTTP.headers(
            'Content-Type'  => 'application/json',
            'Accept'        => 'application/json',
            'X-Date'        => @current_timestamp,
            'Authorization' => authorization_header
          ).get(api_url)

          Response.new(http_response).tap do |response|
            raise(response.error) unless response.http_error?
          end
        end

        private

        def set_authorization_header
          hmac = Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', @app_key, "x-date: #{@current_timestamp}"))
          %(hmac username="#{@app_id}", algorithm="hmac-sha1", headers="x-date", signature="#{hmac}")
        end

        def join_parameters(station_id, direction, date)
          url = ''

          # station id
          if station_id.nil?
            url = "#{API_URL}/Rail/THSR/DailyTimetable/TrainDate/#{date}?$format=JSON"
          else
            url = "#{API_URL}/Rail/THSR/DailyTimetable/Station/#{station_id}/#{date}?$format=JSON"
          end

          # direction
          url += "&$filter=Direction%20eq%20'#{direction}'" unless direction.nil?

          url
        end
      end

      # Response SimpleDelegator
      class Response < SimpleDelegator
        include Errors
        HTTP_ERROR = {
          400 => Errors::BadRequest,
          401 => Errors::Unauthorized,
          404 => Errors::NotFound,
          405 => Errors::MethodNotAllowed
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
