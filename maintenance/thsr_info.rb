# frozen_string_literal: true

require 'net/http'
require 'yaml'
require 'JSON'
require_relative '../init'

def call_thsr_api(url)
  uri = URI(url)
  response = Net::HTTP.get_response(uri)
  JSON.parse(response.body)
end

def filter_api(input)
  input.map do |item|
    {
      park_origin_id: item['CarParkID'],
      name: item['CarParkName']['Zh_tw'],
      city: item['City'],
      latitude: item['CarParkPosition']['PositionLat'].to_s,
      longitude: item['CarParkPosition']['PositionLon'].to_s
    }
  end
end

def refactor_park(parks,city)
  parks.map do |item|
    {
      park_origin_id: item.id,
      name: item.name,
      city: city,
      latitude: item.latitude,
      longtitude: item.longtitude
    }
  end
end

# api_url = "https://traffic.transportdata.tw/MOTC/v1/Parking/OffStreet/CarPark/Rail/THSR?$orderby=CarParkID&$format=JSON"
# data = call_thsr_api(api_url)['CarParks']
city = YAML.load(File.read('maintenance/city.yml'))
api_google = THSRParking::GoogleMap::Api.new(ENV['API_KEY'])
radius = '500'
type = 'parking'
data = []
# parks = api_google.nearby_search(city[0][:latitude], city[0][:longitude], radius, type)
# data.push(refactor_park(parks,city[0][:city]))
city.each do |item|
  parks = api_google.nearby_search(item[:latitude], item[:longtitude], radius, type)
  data.push(*refactor_park(parks,item[:city]))
end
File.write('parks-1.yml', data.to_yaml)
puts data.to_yaml
# city.each do |item|
#   puts item[:city]
# end
