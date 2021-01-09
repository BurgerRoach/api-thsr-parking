# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module THSRParking
  module Entity
    # Domain entity for any coding projects
    class SinglePark < Dry::Struct
      include Dry.Types

      # attribute :update_time,       Strict::String.optional
      attribute :id,                Strict::String
      attribute :name,              Strict::String
      attribute :city_id,           Strict::String
      attribute :city,              Strict::String
      attribute :latitude,          Strict::String
      attribute :longitude,         Strict::String
      attribute :total_spaces,      Strict::Integer
      attribute :available_spaces,  Strict::Integer
      attribute :service_status,    Strict::Integer
      attribute :full_status,       Strict::Integer
      attribute :charge_status,     Strict::Integer
      attribute :average,           Strict::Integer
    end
  end
end
