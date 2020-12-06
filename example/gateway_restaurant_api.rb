# frozen_string_literal: true

require_relative '../config/environment'
require_relative '../app/init'

# call api
api_key = ENV['API_KEY']

lat = '24.11365'
lng = '120.6157'
radius = '500'
type = 'restaurant'

api = THSRParking::GoogleMap::Api.new(api_key)
data = api.nearby_search(lat, lng, radius, type)

data.each do |item| 
    puts item.name
end
# mapper
# result = THSRParking::GoogleMap::Restaurant.new(data).get
# puts result
