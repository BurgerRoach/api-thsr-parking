# frozen_string_literal: true

require 'sequel'

# db_url = "sqlite://app/infrastructure/database/local/dev.db"
# Sequel.connect(db_url)

module THSRParking
  module Database
    # Object-Relational Mapper for Station
    class ParkOrm < Sequel::Model(:parks)
      plugin :timestamps, update_on_create: true

      def self.find_or_create(park_info)
        first(park_origin_id: park_info[:park_origin_id]) || create(park_info)
      end
    end
  end
end
