# frozen_string_literal: true

require 'dry/transaction'

module THSRParking
  module Service
    # Transaction to find restaurants around the park
    class RestaurantAround
      include Dry::Transaction

      step :station_location
      step :find_restaruant

      private

      def station_location(input)
        result = THSRParking::Repository::Locations.find_park_by_id(input[:park_id])

        if result.nil?
          Failure(Response::ApiResult.new(status: :internal_error, message: 'Error: Not found this park in database'))
        else
          Success(
            lat: result.latitude,
            lng: result.longitude,
            radius: input[:radius],
            type: input[:type]
          )
        end
      rescue StandardError
        Failure(Response::ApiResult.new(status: :internal_error, message: e))
      end

      def find_restaruant(input)
        data = GoogleMap::RestaurantMapper.nearby_search(input[:lat], input[:lng], input[:radius], input[:type])
        data = Response::RestaurantsList.new(data)

        Success(Response::ApiResult.new(status: :ok, message: data))
      rescue StandardError => e
        Failure(Response::ApiResult.new(status: :internal_error, message: e))
      end
    end
  end
end
