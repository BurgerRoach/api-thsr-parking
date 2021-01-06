# frozen_string_literal: true

module THSRParking
  # Provides access to THSR City
  module THSR
    # Data Mapper: THSR park spacing data -> SinglePark Entity
    class TimeMapper
      def self.get_time_table(city_id, direction, date)
        @data = THSRTime::Api.new(ENV['PTX_APP_ID'], ENV['PTX_APP_KEY']).search(city_id, direction, date).parse

        result = []
        @data.map do |item|
          result.append(DataMapper.new(item).build_entity)
        end

        result
      end

      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          THSRParking::Entity::THSRTime.new(
            city_id: @data['StationID'],
            name: @data['StationName']['Zh_tw'],
            train_no: @data['TrainNo'],
            direction: @data['Direction'],
            start_station_name: @data['StartingStationName']['Zh_tw'],
            end_station_name: @data['EndingStationName']['Zh_tw'],
            arrival_time: @data['ArrivalTime'],
            departure_time: @data['DepartureTime']
          )
        end
      end
    end
  end
end
