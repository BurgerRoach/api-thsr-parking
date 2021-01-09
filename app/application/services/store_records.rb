# frozen_string_literal: true

require 'dry/transaction'

module THSRParking
  module Service
    # Transaction to find restaurants around the park
    class StoreRecords
      include Dry::Transaction

      step :verfiy_receive
      step :map_records
      step :store_database

      private

      def verfiy_receive(input)
        if input.nil?
          Failure(Response::ApiResult.new(status: :bad_request, message: 'Error: request invalid'))
        else
          Success(input)
        end
      rescue StandardError
        Failure(Response::ApiResult.new(status: :internal_error, message: e))
      end

      def map_records(input)

        records = THSR::RecordMapper.new(input).filiter_store_data
        if records.nil?
          Failure(Response::ApiResult.new(status: :internal_error, message: 'Error: Mapping failed'))
        else
          Success(records)
        end
      rescue StandardError
        Failure(Response::ApiResult.new(status: :internal_error, message: e))
      end

      def store_database(input)

        data = Repository::Records.create_parks_records(input)
        result = Response::RecordsList.new(input)

        Success(Representer::HttpResponse.new(
          Response::ApiResult.new(status: :ok, message: 'ok')
        ))
      rescue StandardError => e
        Failure(Response::ApiResult.new(status: :internal_error, message: e))
      end
    end
  end
end
