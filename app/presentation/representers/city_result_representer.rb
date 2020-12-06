# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'city_representer'

module THSRParking
  module Representer
    # Represents list of cities for API output
    class CityResult < Roar::Decorator
      include Roar::JSON

      property :result, extend: Representer::City
    end
  end
end
