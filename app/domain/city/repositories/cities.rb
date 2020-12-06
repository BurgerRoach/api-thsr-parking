# frozen_string_literal: true

module THSRParking
  module Repository
    # Repository for City Entities
    class Cities
      def self.all
        Database::CityOrm.all.map { |db_city| rebuild_entity(db_city) }
      end

      def self.find_by_name(name)
        Database::CityOrm.first(name: name)
      end

      def self.find_by_id(city_id)
        Database::CityOrm.first(city_id: city_id)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::City.new(
          city_id: db_record.city_id,
          name: db_record.name,
          latitude: db_record.latitude,
          longitude: db_record.longitude
        )
      end
    end
  end
end
