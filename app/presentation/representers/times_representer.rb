# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'time_representer'

module THSRParking
  module Representer
    # Represents list of cities for API output
    class TimesList < Roar::Decorator
      include Roar::JSON

      collection :data, extend: Representer::Time, class: OpenStruct
    end
  end
end
