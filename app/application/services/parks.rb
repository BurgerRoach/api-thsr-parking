# frozen_string_literal: true

require 'dry/monads'

module THSRParking
  module Service
    # Service of park
    class Parks
      include Dry::Monads::Result::Mixin

      def find_by_city_id(city_id)
        # data from thsr api
        data = THSR::BaseMapper.new.find_by_city_id(city_id)

        data_park_ids = []
        data.parks.each do |item|
          data_park_ids.push(item.id)
        end

        # data from database
        db_data = Repository::OtherParks.find_by_city_id(city_id)

        db_data.map do |item|
          data.parks.push(item) unless data_park_ids.include?(item.id)
        end

        if data
          data = Response::ParksList.new(data.update_time, data.parks)
          Success(Response::ApiResult.new(status: :ok, message: data))
        else
          Failure(Response::ApiResult.new(status: :not_found, message: 'Park not found'))
        end
      rescue StandardError => e
        Failure(
          Response::ApiResult.new(status: :internal_error, message: e)
        )
      end

      def find_one_by_park_id(park_id)
        # data from thsr api
        data = THSR::BaseMapper.new.find_one_by_id(park_id)

        # data from database
        data = Repository::OtherParks.find_one_by_park_id(park_id) if data.nil?

        if data
          data = Response::Park.new(data)
          Success(Response::ApiResult.new(status: :ok, message: data))
        else
          Failure(Response::ApiResult.new(status: :not_found, message: 'Park not found'))
        end
      rescue StandardError => e
        Failure(
          Response::ApiResult.new(status: :internal_error, message: e)
        )
      end
    end
  end
end