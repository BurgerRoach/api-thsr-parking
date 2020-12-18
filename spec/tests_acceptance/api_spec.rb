# frozen_string_literal: true

require_relative '../helpers/spec_helper'
require_relative '../helpers/vcr_helper'
require_relative '../helpers/database_helper'
require 'rack/test'

def app
  THSRParking::App
end

describe 'Test API routes' do
  include Rack::Test::Methods

  VcrHelper.setup_vcr
  DatabaseHelper.setup_database_cleaner

  before do
    VcrHelper.configure_vcr_for_thsr
    # DatabaseHelper.wipe_database
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Root route' do
    it 'should successfully return root information' do
      get '/'
      _(last_response.status).must_equal 200

      body = JSON.parse(last_response.body)
      _(body['status']).must_equal 'ok'
      _(body['message']).must_include 'api/v1'
    end
  end

  describe 'Cities route' do
    it 'should see all 9 cities' do
      get '/api/v1/cities'

      result = JSON.parse last_response.body
      _(result['cities'].size).must_equal 9
    end

    it 'city_id should match their city_name' do
      get '/api/v1/cities?city_id=2'

      result = JSON.parse last_response.body
      _(result['result']['name']).must_equal '新竹'
    end

    it 'should see at least official parking lots' do
      get '/api/v1/cities/2/parks'

      result = JSON.parse last_response.body
      _(result['parks'].size).must_be :>=, 3
    end

    # Error tests
    it 'should report correct status for invalid value' do
      get '/api/v1/cities?city_id=2400'

      result = JSON.parse last_response.body
      _(result['status']).must_include 'not_found'
    end

    it 'should report correct status for invalid value' do
      get '/api/v1/city?city_id=2400'

      _(last_response.status).must_equal 404
    end

    it 'should report error for invalid value' do
      get '/api/v1/city'

      _(last_response.status).must_equal 404
    end

    it 'should return nothing for invalid value' do
      get '/api/v1/cities/100/parks'

      result = JSON.parse last_response.body
      _(result['parks'].size).must_equal 0
    end

    it 'should return nothing for invalid value' do
      get '/api/v1/cities/2400/parks'

      result = JSON.parse last_response.body
      _(result['parks'].size).must_equal 0
    end

    it 'should report error for invalid value' do
      get '/api/v1/cities/2/park'

      _(last_response.status).must_equal 404
    end
  end

  describe 'Parks route' do
    it 'should correct info of park' do
      get '/api/v1/parks/2400'

      result = JSON.parse last_response.body
      _(result['result']['id']).must_equal '2400'
      _(result['result']['name']).include? '新竹'
      _(result['result']['city_id']).must_equal '2'
      _(result['result']['city']).must_equal '新竹'
    end

    # Error tests
    it 'should report correct status for invalid value' do
      get '/api/v1/parks/1234'

      _(last_response.status).must_equal 404

      result = JSON.parse last_response.body
      _(result['status']).must_include 'not_found'
    end
  end

  describe 'Restaurants route' do
    it 'should correct info of restaurants' do
      get '/api/v1/restaurants/2400?radius=200'

      _(last_response.status).must_equal 200

      result = JSON.parse last_response.body
      _(result['restaurants'].size).must_be :>=, 1
    end

    # Error tests
    it 'should report correct status for invalid value' do
      get '/api/v1/restaurants/240/radius=200'

      _(last_response.status).must_equal 500

      result = JSON.parse last_response.body
      _(result['status']).must_include 'internal_error'
    end

    it 'should report error for invalid value' do
      get '/api/v1/restaurant/2400/radius=200'

      _(last_response.status).must_equal 404
    end
  end
end
