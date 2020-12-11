# frozen_string_literal: true

require 'json'

# require_relative '../entities/single_park'
# require_relative '../entities/multi_park'

module THSRParking
  # Provides access to THSR park spacing data
  module THSR
    # Data Mapper: THSR park spacing data -> MultiPark Entity
    class BaseMapper
      def initialize(options = {})
        @options = options
      end

      def flatten
        @data = THSR::Api.new.search.parse

        multi_park_instance = THSRParking::Entity::MultiPark.new(
          update_time: @data['UpdateTime'], parks: []
        )

        @data['ParkingAvailabilities'].each do |item|
          # find park's position
          park_info = Database::ParkOrm.first(park_origin_id: item['CarParkID'])
          item['latitude'] = park_info.latitude
          item['longitude'] = park_info.longitude

          multi_park_instance.parks.append(DataMapper.new(item).build_entity)
        end

        filter_by_options if @options
        multi_park_instance
      end

      def find_one_by_id(park_id)
        @data = THSR::Api.new.search.parse

        result = nil
        @data['ParkingAvailabilities'].each do |item|
          if item['CarParkID'] == park_id
            park_info = Database::ParkOrm.first(park_origin_id: item['CarParkID'])
            item['latitude'] = park_info.latitude
            item['longitude'] = park_info.longitude
            result = DataMapper.new(item).build_entity
            break
          end
        end

        result
      end

      private

      def filter_by_options
        options_select_service_status if @options.key?(:service_status)
        options_select_service_available_level if @options.key?(:service_available_level)
        options_select_charge_status if @options.key?(:charge_status)
      end

      # def options_select_service_status
      #   @multi_park_instance.parks.select! { |item| item.service_status == @options[:service_status] }
      # end

      # def options_select_service_available_level
      #   @multi_park_instance.parks.select! { |item| item.available_spaces >= @options[:service_available_level] }
      # end

      # def options_select_charge_status
      #   @multi_park_instance.parks.select! { |item| item.charge_status == @options[:charge_status] }
      # end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          THSRParking::Entity::SinglePark.new(
            id: @data['CarParkID'],
            name: @data['CarParkName']['Zh_tw'],
            latitude: @data['latitude'],
            longitude: @data['longitude'],
            total_spaces: @data['TotalSpaces'],
            available_spaces: @data['AvailableSpaces'],
            service_status: @data['ServiceStatus'],
            full_status: @data['FullStatus'],
            charge_status: @data['ChargeStatus']
          )
        end
      end
    end
  end
end
