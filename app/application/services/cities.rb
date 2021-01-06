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
        Failure(Response::ApiResult.new(status: :internal_error, message: e))
      end

      def find_by_name(name)
        data = Repository::Cities.find_by_name(name)

        if data
          data = Response::City.new(data)
          Success(Response::ApiResult.new(status: :ok, message: data))
        else
          Failure(Response::ApiResult.new(status: :not_found, message: 'City not found'))
        end
      rescue StandardError => e
        Failure(Response::ApiResult.new(status: :internal_error, message: e))
      end

      def find_by_id(id)
        data = Repository::Cities.find_by_id(id)

        if data
          data = Response::City.new(data)
          Success(Response::ApiResult.new(status: :ok, message: data))
        else
          Failure(Response::ApiResult.new(status: :not_found, message: 'City not found'))
        end
      rescue StandardError => e
        Failure(Response::ApiResult.new(status: :internal_error, message: e))
      end

      def find_time(city_id, direction, date)
        data = THSR::TimeMapper.get_time_table(city_id, direction, date)

        if data
          data = Response::TimesList.new(data)
          Success(Response::ApiResult.new(status: :ok, message: data))
        else
          Failure(Response::ApiResult.new(status: :not_found, message: "the city's time not found"))
        end
      rescue StandardError => e
        Failure(Response::ApiResult.new(status: :internal_error, message: e))
      end
    end
  end
end
