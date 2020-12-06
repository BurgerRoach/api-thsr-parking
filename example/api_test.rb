# frozen_string_literal: true

require_relative '../config/environment'
require_relative '../app/init'

# api = THSR::Api.new
# opts = {
#   'service_status': 1,
#   'service_available_level': 10,
#   'charge_status': 1
# }
# id = '2500'
# data = api.search(opts)
# print data
# park = api.search_by_park_id(id, opts)
# puts "\n\n#{park}"

# city = ''
# data = api.search(opts)
# puts data
# pkl_city = api.search_by_city(city, opts)
# puts "\n#{pkl_city}"

city = '台中'
api = THSRParking::THSR::Api.new
data = api.search_by_city(city)

# city_park = THSRParking::Entity::MultiPark.new(update_time:data)
# parks = data['parks']
puts data['parks']
# puts parks[0]['name']
