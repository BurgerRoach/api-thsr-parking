# frozen_string_literal: false

require_relative '../helpers/spec_helper'
require_relative '../helpers/vcr_helper'

describe 'Tests THSR API library' do
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock
  end

  before do
    VCR.insert_cassette CASSETTE_FILE, record: :new_episodes, match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end
  describe 'Search real time inquiry information' do
    it 'HAPPY: should provide correct search information' do
      data = THSR::Api.new.search

      _(data['ParkingAvailabilities']).must_be_instance_of(Array)
      _(data['ParkingAvailabilities'].size).wont_equal 0
    end

    it 'HAPPY: should provide correct search information' do
      opts = { 'service_status': 1, 'charge_status': 1, 'service_available_level': 10 }
      data = THSR::Api.new.search(opts)
      result = data['ParkingAvailabilities'].sample
      _(result['AvailableSpaces']).must_be :>=, 10
      _(result['ServiceStatus']).must_equal 1
    end

    it 'HAPPY: should provide correct search information' do
      opts = { 'charge_status': 2 }
      data = THSR::Api.new.search(opts)

      _(data['ParkingAvailabilities'].size).must_equal 0
    end

    it 'SAD: should raise exception on incorrect options' do
      _(proc do
        THSR::Api.new.search({ 'hello': 2 })
      end).must_raise Errors::OptionsError
    end
  end

  describe 'Search Park information' do
    it 'HAPPY: should provide correct search park information' do
      testing = { 'ID': '2600', 'Name': '高鐵苗栗站戶外平面停車場(P2)' }
      data = THSR::Api.new.search_by_park_id(testing[:ID])
      _(data['AvailableSpaces']).wont_be_nil
      _(data['CarParkID']).must_equal testing[:ID]
      _(data['CarParkName']).must_equal testing[:Name]
      _(data['AvailableSpaces']).must_be_instance_of(Integer)
    end

    it 'HAPPY: should provide correct search park information when not found' do
      opts = { 'charge_status': 2 }
      id = '2100'
      data = THSR::Api.new.search_by_park_id(id, opts)
      _(data).must_be_nil
    end

    it 'SAD: should raise exception on incorrect ID format' do
      id = '111'
      _(proc do
        THSR::Api.new.search_by_park_id(id)
      end).must_raise Errors::IDFormatError
    end
  end

  describe 'Search Park information by city' do
    it 'HAPPY: should provide correct search park information with city name' do
      opts = { 'charge_status': 1 }
      testing_city = '新竹'
      data = THSR::Api.new.search_by_city(testing_city, opts)
      _(data['ParkingAvailabilities'].size).must_equal 3
      data['ParkingAvailabilities'].each do |n|
        _(n['CarParkName'][2..3]).must_equal testing_city
        _(n['AvailableSpaces']).must_be_instance_of(Integer)
      end
    end

    it 'HAPPY: should provide correct search park information when not found using city name' do
      opts = { 'charge_status': 2 }
      city_str = '浙江'
      data = THSR::Api.new.search_by_city(city_str, opts)
      _(data).must_be_nil
    end

    it 'SAD: should raise exception on city name not in string' do
      city = 1234
      _(proc do
        THSR::Api.new.search_by_city(city)
      end).must_raise Errors::StrFormatError
    end
  end
end
