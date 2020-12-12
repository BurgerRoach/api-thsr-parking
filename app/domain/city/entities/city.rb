# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module THSRParking
  module Entity
    # Domain entity for any city
    class City < Dry::Struct
      include Dry.Types

      attribute :city_id,           Strict::String
      attribute :name,              Strict::String
      attribute :latitude,          Strict::String
      attribute :longitude,         Strict::String
      attribute :img_src,           Strict::String
      attribute :credit,            Strict::String
    end
  end
end
