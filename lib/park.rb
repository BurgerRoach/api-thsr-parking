# frozen_string_literal: true

module THSR
  # Model for park
  class Park
    def initialize(park_id, filtered_data)
      @data = filtered_data
      @park_id = park_id
    end

    def onehash
      [@data.first].to_h.merge(@data['ParkingAvailabilities'].inject(:merge)) # Transform into one hash
    end

    def find_id
      @data['ParkingAvailabilities'].select! { |item| item['CarParkID'] == @park_id }
    end

    def get
      raise Errors::IDFormatError if invalid_id_format?

      find_id
      return onehash if @data['ParkingAvailabilities'][0]

      nil # 'Sorry, no parking lot can meet your needs'
    end

    private

    def invalid_id_format?
      id_format = /^\d{4}$/
      return true unless id_format.match(@park_id)

      false
    end
  end
end
