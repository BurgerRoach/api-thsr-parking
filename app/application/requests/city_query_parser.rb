# frozen_string_literal: true

require 'dry/monads/result'
require 'json'

module THSRParking
  module Request
    # City request query parser
    class CityQueryParser
      include Dry::Monads::Result::Mixin

      ACCEPT_QUERY = %w[city_id city_name].freeze

      def initialize(param)
        @param = param
      end

      def parse
        if many? || invalid_query?
          Failure('City query error')
        end

        Success(retrieve_query)
      end

      def many?
        @param.length > 1
      end

      def invalid_query?
        @param.each_key { |k| return true unless ACCEPT_QUERY.include?(k) == true }
      end

      def retrieve_query
        k = @param.keys[0]
        [k, @param[k]]
      end
    end
  end
end
