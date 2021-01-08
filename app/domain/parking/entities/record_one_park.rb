# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module THSRParking
  module Entity
    # Domain entity for any coding projects
    class RecordOnePark < Dry::Struct
      include Dry.Types

      attribute :id,                Strict::String
      attribute :available_spaces,  Strict::Integer
      attribute :update_time,       Strict::String
    end
  end
end
