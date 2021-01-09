# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents essential Repo information for API output
module THSRParking
  module Representer
    # Represent a Restaurant entity as Json
    class Record < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :id
      property :available_spaces
      property :update_time
    end
  end
end
