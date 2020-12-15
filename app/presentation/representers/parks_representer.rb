# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'park_representer'

module THSRParking
  module Representer
    # Represents list of cities for API output
    class ParksList < Roar::Decorator
      include Roar::JSON

      property :update_time
      collection :parks, extend: Representer::Park,class: OpenStruct
    end
  end
end
