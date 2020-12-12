# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents essential Repo information for API output
module THSRParking
  module Representer
    # Represent a City entity as Json
    class City < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :city_id
      property :name
      property :latitude
      property :longitude
      property :img_src
      property :credit
    end
  end
end
