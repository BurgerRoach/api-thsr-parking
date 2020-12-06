# frozen_string_literal: true

require 'json'

module THSRParking
  # Provides access to Google Places Restaurant data
  module GoogleMap
    # Data Mapper: Google Places Restaurant data -> Restaurant Entity
    class RestaurantMapper
      def self.nearby_search(lat, lng, radius, type)
        @data = GoogleMap::Api.new(ENV['API_KEY']).nearby_search(lat, lng, radius, type).parse

        result = []
        @data['results'].map do |item|
          result.append(DataMapper.new(item).build_entity)
        end

        result
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data)
          @data = data
          @data['user_ratings_total'] ||= 0
          @data['vicinity'] ||= ''
        end

        def build_entity
          THSRParking::Entity::Restaurant.new(
            id: @data['place_id'],
            name: @data['name'],
            latitude: @data['geometry']['location']['lat'].to_s,
            longtitude: @data['geometry']['location']['lng'].to_s,
            open_status: @data.key?('opening_hours') ? @data['opening_hours']['open_now'] : false,
            vicinity: @data['vicinity'],
            rating: @data['rating'].to_s,
            user_ratings_total: @data['user_ratings_total'],
            photo_reference: @data.key?('photos') ? @data['photos'][0]['photo_reference'] : ''
          )
        end
      end
    end
  end
end
