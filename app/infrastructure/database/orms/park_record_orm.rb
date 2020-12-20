# frozen_string_literal: true

require 'sequel'

module THSRParking
  module Database
    # Object-Relational Mapper for Station
    class ParkRecordOrm < Sequel::Model(:parks)
      plugin :timestamps, update_on_create: true

      def self.find_or_create(park_info)
        first(park_origin_id: park_info[:park_origin_id]) || create(park_info)
      end
    end
  end
end
