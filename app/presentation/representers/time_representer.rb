# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

# Represents essential Repo information for API output
module THSRParking
  module Representer
    # Represent a Time entity as Json
    class Time < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :city_id
      property :name
      property :train_no
      property :direction
      property :start_station_name
      property :end_station_name
      property :arrival_time
      property :departure_time
    end
  end
end
