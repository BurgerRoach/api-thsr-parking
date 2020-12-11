# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents essential Repo information for API output
module THSRParking
  module Representer
    # Represent a Park entity as Json
    class Park < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :id
      property :name
      property :latitude
      property :longitude
      property :total_spaces
      property :available_spaces
      property :service_status
      property :full_status
      property :charge_status
    end
  end
end
