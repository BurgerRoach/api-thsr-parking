# frozen_string_literal: true
require_relative 'otherparks'

module THSRParking
  module Repository
    # Finds the right food for an entity object or class
    class For
      ENTITY_MultiPark = {
        Entity::MultiPark => OtherParks
      }.freeze

      def self.klass(entity_klass)
        ENTITY_MultiPark[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_MultiPark[entity_object.class]
      end
    end
  end
end
