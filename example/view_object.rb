# frozen_string_literal: true

require_relative '../config/environment'
require_relative '../app/init'

api = THSRParking::THSR::Api.new
data = api.search_by_city('新竹')
time = data.update_time
parks = data.parks

# view_parks = Views::Park.new(parks) # turn into view object

# view_parks.each do |item|
#     puts item.name
# end
puts parks.name

