# frozen_string_literal: true

module THSR
  # City
  class City
    def initialize(filtered_data, city)
      @data = filtered_data
      @city = city
    end

    def get
      raise Errors::StrFormatError if invalid_city_format?

      hash = {}
      parking_availabilities = @data['ParkingAvailabilities']
      hash['UpdateTime'] = @data['UpdateTime']
      filtered_data = screening(parking_availabilities)
      hash['ParkingAvailabilities'] = filtered_data
      return hash unless hash['ParkingAvailabilities'].length.zero?
    end

    private

    def screening(hash)
      arr = []
      hash.each do |n|
        arr << n if n['CarParkName'].include?(@city)
      end
      arr
    end

    def invalid_city_format?
      return true unless @city.is_a? String

      false
    end
  end
end
