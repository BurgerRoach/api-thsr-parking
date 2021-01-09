# frozen_string_literal: true

module THSRParking
  # Provides access to THSR park spacing data
  module THSR
    # Data Mapper: THSR park spacing data -> SinglePark Entity
    class RecordMapper
      def initialize(data)
        @data = data
      end

      def filiter_store_data
        @data = JSON.parse(@data)

        # many_park_record_instance = THSRParking::Entity::RecordManyPark.new(
        #   parks: []
        # )

        record = @data['ParkingAvailabilities'].map do |item|
          item['available_spaces'] = item['Availabilities'][0]['AvailableSpaces']
          item['update_time'] = @data['UpdateTime']
          item['park_origin_id'] = item['CarParkID']
          item.slice('update_time', 'park_origin_id','available_spaces')
          # many_park_record_instance.parks.push(DataMapper.new(item).build_record_entity)
        end

        # many_park_record_instance
      end

      private

      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_record_entity
          THSRParking::Entity::RecordOnePark.new(
            id: @data['park_origin_id'],
            available_spaces: @data['available_spaces'],
            update_time: @data['update_time']
          )
        end
      end
    end
  end
end
