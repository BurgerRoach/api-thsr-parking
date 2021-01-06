# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module THSRParking
  module Entity
    # Domain entity for time
    class THSRTime < Dry::Struct
      include Dry.Types

      attribute :city_id,             Strict::String
      attribute :name,                Strict::String
      attribute :train_no,            Strict::String
      attribute :direction,           Strict::Integer
      attribute :start_station_name,  Strict::String
      attribute :end_station_name,    Strict::String
      attribute :arrival_time,        Strict::String
      attribute :departure_time,      Strict::String
    end
  end
end
