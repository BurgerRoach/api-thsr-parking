# frozen_string_literal: true

module THSRParking
  module Repository
    # Repository for Project Entities
    class OtherParks
      def self.all
        Database::ParkOrm.all.map { |db_park| rebuild_entity(db_park) }
      end

      def self.find_park_by_city(city)
        db_record = Database::ParkOrm.where(city: city).all
        dodo_id = /^\d{4}$/.freeze
        db_record.select! do |item|
          dodo_id.match?(item.park_origin_id) == false
        end
        rebuild_many(db_record)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::SinglePark.new(
          id: db_record.park_origin_id,
          name: db_record.name,
          total_spaces: 0,
          available_spaces: 1,
          service_status: 1,
          full_status: 0,
          charge_status: 1
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
