# frozen_string_literal: true

require_relative 'record_one_park'

module THSRParking
  module Entity
    # Domain entity for any coding projects
    class RecordManyPark < Dry::Struct
      include Dry.Types
      attribute :parks,        Strict::Array.of(RecordOnePark)
    end
  end
end
