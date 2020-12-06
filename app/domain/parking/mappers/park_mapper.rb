# frozen_string_literal: true

module THSRParking
  # Provides access to THSR park spacing data
  module THSR
    # Data Mapper: THSR park spacing data -> SinglePark Entity
    class ParkMapper
      def initialize(data_instance, park_id)
        @data_instance = data_instance
        @park_id = park_id
      end

      def get
        # raise Errors::IDFormatError if invalid_id_format?

        select_by_id

        @data_instance
      end

      private

      def select_by_id
        @data_instance.parks.select! { |item| item.id == @park_id }
      end

      # def invalid_id_format?
      #   id_format = /^\d{4}$/
      #   return true unless id_format.match(@park_id)

      #   false
      # end
    end
  end
end
