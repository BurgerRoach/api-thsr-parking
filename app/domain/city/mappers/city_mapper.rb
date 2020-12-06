# frozen_string_literal: true
# THSRParking::THSR::City
module THSRParking
  # Provides access to THSR City
  module THSR
    # Data Mapper: THSR park spacing data -> SinglePark Entity
    class CityMapper
      def initialize(data_instance, city)
        @data_instance = data_instance # MultiPark instance
        @city = city
      end

      def get
        raise Errors::StrFormatError if invalid_city_format?

        select_by_city

        # select_by_id

        @data_instance
      end

      private

      # def select_by_id
      #   @data_instance.parks.select! { |item| item.city_id.include?(@city_id) }
      # end

      def select_by_city
        @city = '左營' if @city == '高雄'
        @data_instance.parks.select! { |item| item.name.include?(@city) }
      end

      def invalid_city_format?
        return true unless @city.is_a? String

        false
      end
    end
  end
end
