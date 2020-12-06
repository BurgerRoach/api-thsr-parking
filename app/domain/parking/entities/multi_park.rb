# frozen_string_literal: true

require_relative 'single_park'

module THSRParking
  module Entity
    # Domain entity for any coding projects
    class MultiPark < Dry::Struct
      include Dry.Types

      attribute :update_time,  Strict::String
      attribute :parks,        Strict::Array.of(SinglePark)
    end
  end
end
