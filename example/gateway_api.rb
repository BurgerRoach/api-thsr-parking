# frozen_string_literal: true

require_relative '../config/environment'
require_relative '../app/init'

api = THSRParking::THSR::Api.new

# opts = {
#   'service_status': 1,
#   'service_available_level': 60,
#   'charge_status': 1
# }

# test city space remain
filtered_data = api.search({}, 'dry')
city = '新竹'

temp = THSRParking::THSR::City.new(filtered_data, city).get
# result = THSRParking::Value::Remain.new(temp).nothing_left?
puts temp

# test api.get
# park_id = '2100'
# data = api.search_by_park_id(park_id).get

# puts data.update_time

# filtered_data = api.search({}, 'dry')
# temp_park = THSRParking::THSR::Park.new(filtered_data, park).get
# puts temp_park.inspect

## City ##
# data = api.search_by_city('新竹')
# print data

## Park ID ##
# data = api.search_by_park_id('2600')
# print data['parks']
