# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'park_representer'

module THSRParking
  module Representer
    # Represents single park result for API output
    class ParkResult < Roar::Decorator
      include Roar::JSON

      property :result, extend: Representer::Park
    end
  end
end
