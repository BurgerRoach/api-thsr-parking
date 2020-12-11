# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents essential Repo information for API output
module THSRParking
  module Representer
    # Represent a Restaurant entity as Json
    class Restaurant < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :id
      property :name
      property :latitude
      property :longitude
      property :open_status
      property :vicinity
      property :rating
      property :user_ratings_total
      property :photo_reference
    end
  end
end
