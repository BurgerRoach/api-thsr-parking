# frozen_string_literal: true

module THSRParking
  module Repository
    # Repository for Project Entities
    class OtherParks
      def self.all
        Database::ParkOrm.all.map { |db_park| rebuild_entity(db_park) }
      end

      def self.find_by_city_id(city_id)
        db_record = Database::ParkOrm.where(city_id: city_id).all

        result = []
        db_record.each do |item|
          result.push(rebuild_entity(item))
        end

        result
      end

      def self.find_one_by_park_id(park_id)
        db_record = Database::ParkOrm.where(park_origin_id: park_id).first
        rebuild_entity(db_record)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::SinglePark.new(
          id: db_record.park_origin_id,
          name: db_record.name,
          city_id: db_record.city_id,
          city: db_record.city,
          latitude: db_record.latitude,
          longitude: db_record.longitude,
          total_spaces: 0,
          available_spaces: 0,
          service_status: 1,
          full_status: 0,
          charge_status: 0,
          average: 0
        )
      end

      def self.rebuild_many(db_records)
        return nil unless db_records

        parks = []
        db_records.map do |db_park|
          parks.push(*OtherParks.rebuild_entity(db_park))
        end

        Entity::MultiPark.new(
          update_time: "today",
          parks: parks
        )
      end
    end
  end
end
