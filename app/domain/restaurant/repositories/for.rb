# frozen_string_literal: true
require_relative 'locations'

module THSRParking
  module Repository
    # Finds the right food for an entity object or class
    class For
      ENTITY_LOCATION = {
        Entity::Location => Locations
      }.freeze

      def self.klass(entity_klass)
        ENTITY_LOCATION[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_LOCATION[entity_object.class]
      end
    end
  end
end
