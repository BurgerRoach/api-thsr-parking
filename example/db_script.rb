# frozen_string_literal: true

require 'sequel'

# connect to database
db_url = "sqlite://app/infrastructure/database/local/dev.db"
DB = Sequel.connect(db_url)

# stations table
parks = DB[:parks]
puts parks.count

# # select station = 新竹
# stat = stations.where(station: '高鐵新竹站')
# puts stat.first

# # restaurants table
# restaurants = DB[:restaurants]
# puts restaurants.first

# # select restaurant = 新竹
# stat = restaurants.where(restaurant: '盜飯炙火烤肉定食')
# puts stat.first
