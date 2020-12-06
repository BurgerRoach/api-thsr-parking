# frozen_string_literal: true

module THSR
  # Base class for process raw data
  class Base
    def initialize(raw_data, options)
      @data = raw_data
      @options = options
    end

    def flatten
      useless_key = %w[UpdateInterval SrcUpdateTime SrcUpdateInterval AuthorityCode]
      useless_key.each { |k| @data.delete(k) }
      @data['ParkingAvailabilities'].map do |item|
        item['CarParkName'] = item['CarParkName']['Zh_tw']
        item.delete('Availabilities')
      end

      filter_by_options if @options
      @data
    end

    private

    def filter_by_options
      options_select_service_status if @options.key?(:service_status)
      options_select_service_available_level if @options.key?(:service_available_level)
      options_select_charge_status if @options.key?(:charge_status)
    end

    def options_select_service_status
      @data['ParkingAvailabilities'].select! { |item| item['ServiceStatus'] == @options[:service_status] }
    end

    def options_select_service_available_level
      @data['ParkingAvailabilities'].select! { |item| item['AvailableSpaces'] >= @options[:service_available_level] }
    end

    def options_select_charge_status
      @data['ParkingAvailabilities'].select! { |item| item['ChargeStatus'] == @options[:charge_status] }
    end
  end
end
