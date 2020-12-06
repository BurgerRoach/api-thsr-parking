# frozen_string_literal: true

require 'dry/monads'

module THSRParking
  module Service
    # Service of park
    class Parks
      include Dry::Monads::Result::Mixin

      def find_park_by_city(city_name)
        # data from thsr api
        raw_data = THSR::BaseMapper.new.flatten
        data = THSR::CityMapper.new(raw_data, city_name).get

        # data from database
        db_data = Repository::OtherParks.find_park_by_city(city_name)

        # merge data from thsr api data & database data
        parks = data.parks.push(*db_data.parks)
        update_time = data.update_time

        Success([parks, update_time])
      rescue StandardError => e
        Failure(e.to_s)
      end
    end
  end
end
