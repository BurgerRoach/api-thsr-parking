# frozen_string_literal: false

require_relative '../helpers/spec_helper'
require_relative '../helpers/vcr_helper'
require_relative '../../lib/city'
require_relative '../../lib/park'
require_relative '../../app/infrastructure/gateways/api'

describe 'Tests THSR API library' do
  before do
    VcrHelper.configure_vcr_for_thsr
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Search real time inquiry information' do
    it 'HAPPY: should provide correct search information' do
      data = THSRParking::THSR::Api.new.search
      # _(data['ParkingAvailabilities']).must_be_instance_of(Array)
      _(data).wont_equal 0
    end

    # it 'HAPPY: should provide correct search information' do
    #   opts = { 'service_status': 1, 'charge_status': 1, 'service_available_level': 10 }
    #   data = THSRParking::THSR::Api.new.search
    #   result = data['parks']
    #   _(result['available_spaces']).must_be :>=, 10
    #   _(result['service_status']).must_equal 1
    # end

    # it 'HAPPY: should provide correct search information' do
    #   opts = { 'charge_status': 2 }
    #   data = THSRParking::THSR::Api.new.search
    #   _(data['parks'].size).must_equal 0
    # end

    # it 'SAD: should raise exception on incorrect options' do
    #   _(proc do
    #     THSRParking::THSR::Api.new.search({ 'hello': 2 })
    #   end).must_raise Errors::OptionsError
    # end
  end

  # describe 'Search Park information' do
  #   it 'HAPPY: should provide correct search park information......' do
  #     testing = { 'ID': 2600, 'Name': '高鐵苗栗站戶外平面停車場(P2)' }
  #     data = THSRParking::THSR::Api.new.search_by_park_id(testing[:ID])
  #     puts data
  #     _(data['parks'][0]['available_spaces']).wont_be_nil
  #     _(data['parks'][0]['id']).must_equal testing[:ID]
  #     _(data['parks'][0]['name']).must_equal testing[:Name]
  #     _(data['parks'][0]['available_spaces']).must_be_instance_of(Integer)
  #   end

  #   it 'HAPPY: should provide correct search park information when not found' do
  #     opts = { 'charge_status': 2 }
  #     id = '2100'
  #     data = THSRParking::THSR::Api.new.search_by_park_id(id)
  #     _(data['parks'].size).must_equal 0
  #   end

  #   it 'SAD: should raise exception on incorrect ID format' do
  #     id = '111'
  #     _(proc do
  #       THSRParking::THSR::Api.new.search_by_park_id(id)
  #     end).must_raise Errors::IDFormatError
  #   end
  # end

  # describe 'Search Park information by city' do
  #   it 'HAPPY: should provide correct search park information with city name' do
  #     opts = { 'charge_status': 1 }
  #     testing_city = '新竹'
  #     data = THSRParking::THSR::Api.new.search_by_city(testing_city, opts)
  #     _(data['parks'].size).must_equal 3
  #     data['parks'].each do |n|
  #       _(n['name'][2..3]).must_equal testing_city
  #       _(n['available_spaces']).must_be_instance_of(Integer)
  #     end
  #   end

  #   it 'HAPPY: should provide correct search park information when not found using city name' do
  #     # opts = { 'charge_status': 2 }
  #     city_str = '浙江'
  #     data = THSRParking::THSR::Api.new.search_by_city(city_str, opts)
  #     _(data['parks'].size).must_equal 0
  #   end

  #   it 'SAD: should raise exception on city name not in string' do
  #     city = 1234
  #     _(proc do
  #       THSRParking::THSR::Api.new.search_by_city(city)
  #     end).must_raise Errors::StrFormatError
  #   end
  # end
end
