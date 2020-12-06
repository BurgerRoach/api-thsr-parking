# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module THSRParking
  module Entity
    # Domain entity for any coding projects
    class Restaurant < Dry::Struct
      include Dry.Types

      attribute :id,                  Strict::String
      attribute :name,                Strict::String
      attribute :latitude,            Strict::String
      attribute :longtitude,          Strict::String
      attribute :open_status,         Strict::Bool
      attribute :vicinity,            Strict::String
      attribute :rating,              Strict::String
      attribute :user_ratings_total,  Strict::Integer
      attribute :photo_reference,     Strict::String
    end
  end
end
