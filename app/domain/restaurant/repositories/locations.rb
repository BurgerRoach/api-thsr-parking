# frozen_string_literal: true

module THSRParking
  module Repository
    # Repository for Project Entities
    class Locations
      def self.all
        Database::ParkOrm.all.map { |db_park| rebuild_entity(db_park) }
      end

      def self.find_park_by_id(park_id)
        db_record = Database::ParkOrm.first(park_origin_id: park_id)
        rebuild_entity(db_record)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::Location.new(
          id: db_record.park_origin_id,
          city: db_record.city,
          name: db_record.name,
          latitude: db_record.latitude,
          longitude: db_record.longitude
        )
      end
    end
  end
end
