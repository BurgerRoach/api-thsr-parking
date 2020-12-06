# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module THSRParking
  module Entity
    # Domain entity for any coding projects
    class Location < Dry::Struct
      include Dry.Types

      attribute :id,                Strict::String
      attribute :city,              Strict::String
      attribute :latitude,          Strict::String
      attribute :longitude,         Strict::String
      attribute :name,              Strict::String
    end
  end
end
