# frozen_string_literal: true

require 'dry/transaction'

module THSRParking
  module Service
    # Service of city
    class Cities
      include Dry::Transaction

      def list
        cities = Repository::Cities.all
        cities = Response::CitiesList.new(cities)

        Success(Response::ApiResult.new(status: :ok, message: cities))
      rescue StandardError => e
        Failure(
          Response::ApiResult.new(status: :internal_error, message: e)
        )
      end

      def find_by_name(name)
        city = Repository::Cities.find_by_name(name)
        city = Response::City.new(city)

        Success(Response::ApiResult.new(status: :ok, message: city))
      rescue StandardError => e
        Failure(
          Response::ApiResult.new(status: :internal_error, message: e)
        )
      end

      def find_by_id(id)
        city = Repository::Cities.find_by_id(id)
        city = Response::City.new(city)

        Success(Response::ApiResult.new(status: :ok, message: city))
      rescue StandardError => e
        Failure(
          Response::ApiResult.new(status: :internal_error, message: e)
        )
      end
    end
  end
end
