# frozen_string_literal: true

require_relative '../config/environment'
require_relative '../app/init'

### test  Repository Stations ###
# test find station by id
result = THSRParking::Repository::Locations.find_park_by_id('2400')
puts result.latitude
puts result.longitude
park_location = {
    'lat': result.latitude,
    'lng': result.longitude
}
puts park_location['lat']

# projects = THSRParking::Repository::For.klass(Entity::Location).find_full_names(session[:watching])

# # test find station by name
# result = THSRParking::Repository::Stations.find_station_by_name('高鐵台中站')
# puts result.to_h

# # test find_station_retaurant
# # result = THSRParking::Repository::Stations.find_station_retaurant('1')

# ### test  Repository Restaurants ###
# # test find restaurant by id
# result = THSRParking::Repository::Restaurants.find_restaurant_by_id('3')
# puts result.to_h

# # test find restaurant by name
# result = THSRParking::Repository::Restaurants.find_restaurant_by_name('盜飯炙火烤肉定食')
# puts result.to_h

# # test add thumbsup and return entity
# result = THSRParking::Value::Thumbsup.new(result).adds_up

# # test add thumbsdwon and return entity
# result = THSRParking::Value::Thumbsdown.new(result).adds_down

# # test change type and return entity
# result = THSRParking::Value::Type.new(result).change_type('烤肉')

# # test update thumbsup thumbsdown and type in database and return nothing
# THSRParking::Repository::Restaurants.update_thumbs_type(result.id,result.thumbsdown,result.thumbsup,result.type)

# # find the same restaurant again to check whether it update in db
# result = THSRParking::Repository::Restaurants.find_restaurant_by_name('盜飯炙火烤肉定食')
# puts result.to_h
