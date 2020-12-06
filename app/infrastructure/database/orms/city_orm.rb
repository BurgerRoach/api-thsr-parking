# frozen_string_literal: true

require 'sequel'

# db_url = "sqlite://app/infrastructure/database/local/dev.db"
# Sequel.connect(db_url)

module THSRParking
  module Database
    # Object-Relational Mapper for Station
    class CityOrm < Sequel::Model(:city)
      plugin :timestamps, update_on_create: true

      one_to_many :city_parks,
                  class: :'THSRParking::Database::ParkOrm',
                  key: :park_origin_id

      def self.find_or_create(city_info)
        first(city_id: city_info[:city_id]) || create(city_info)
      end
    end
  end
end
