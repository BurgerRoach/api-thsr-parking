# frozen_string_literal: true

require_relative 'cities'

module THSRParking
  module Repository
    # Finds the right food for an entity object or class
    class For
      ENTITY_CITY = {
        Entity::City => Cities
      }.freeze

      def self.klass(entity_klass)
        ENTITY_CITY[entity_klass]
      end

      def self.entity(entity_object)
        ENTITY_CITY[entity_object.class]
      end
    end
  end
end
