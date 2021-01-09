# frozen_string_literal: true

module THSRParking
  module Repository
    # Repository for Project Entities
    class Records
      def self.all
        Database::ParkRecordOrm.all.map { |db_park_record| rebuild_entity(db_park_record) }
      end

      def self.find_one_by_park_id(park_id)
        db_record = Database::ParkRecordOrm.where(park_origin_id: park_id).first
        rebuild_entity(db_record)
      end

      def self.create_parks_records(parks_records)
        parks_records.each do |item|
          Database::ParkRecordOrm.find_or_create(item)
        end
      end

      def self.find_avg_by_park_id(park_id)
        if Econfig.env == 'production'
          taipei = Time.now+(60*60*8)
        else
          taipei = Time.now
        end
        Database::ParkRecordOrm.where(
          :update_time => (taipei - 60*60*3)..(taipei),
          :park_origin_id => park_id).avg(:available_spaces)
      end

      private

      def self.rebuild_entity(db_record)
        return nil unless db_record

        Entity::RecordOnePark.new(
          id: db_record.park_origin_id,
          available_spaces: db_record.available_spaces,
          update_time: db_record.update_time
        )
      end

      def self.rebuild_many(db_records)
        return nil unless db_records

        parks_records = []
        db_records.map do |db_park_record|
          parks_records.push(*Records.rebuild_entity(db_park_record))
        end

        Entity::RecordManyPark.new(
          parks: parks_records
        )
      end
    end
  end
end
