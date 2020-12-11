# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'restaurant_representer'

module THSRParking
  module Representer
    # Represents list of restaurants for API output
    class RestaurantsList < Roar::Decorator
      include Roar::JSON

      collection :restaurants, extend: Representer::Restaurant
    end
  end
end
