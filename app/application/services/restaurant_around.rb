# frozen_string_literal: true

require 'dry/transaction'

module THSRParking
  module Service
    # Transaction to store project from Github API to database
    class RestaurantAround
      include Dry::Transaction

      step :station_location
      step :find_restaruant

      private

      def station_location(input)
        result = THSRParking::Repository::Locations.find_park_by_id(input[:park_id])

        if result.nil?
          Failure("Error: Not found this park in database")
        else
          Success(lat: result.latitude, lng: result.longitude)
        end
      rescue StandardError => e
        puts e.backtrace.join("\n")
        Failure('Having trouble accessing the database')
      end

      def find_restaruant(input)
        radius = '500'
        type = 'restaurant'

        data = GoogleMap::RestaurantMapper.nearby_search(input[:lat], input[:lng], radius, type)
        if data.nil?
          input[:data] = nil
        else
          input[:data] = data
        end

        Success(input)
      rescue StandardError => e
        Failure(e.to_s)
      end
    end
  end
end
