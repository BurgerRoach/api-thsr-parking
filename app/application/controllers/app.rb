# frozen_string_literal: true

require 'roda'
require 'json'

module THSRParking
  # Web App
  class App < Roda
    plugin :halt
    plugin :flash
    plugin :all_verbs # allows DELETE and other HTTP verbs beyond GET/POST
    use Rack::MethodOverride # for other HTTP verbs (with plugin all_verbs)

    route do |routing|
      response['Content-Type'] = 'application/json'

      # GET /
      routing.root do
        message = "THSR Parking API v1 at /api/v1/ in #{App.environment} mode"

        result_response = Representer::HttpResponse.new(
          Response::ApiResult.new(status: :ok, message: message)
        )

        response.status = result_response.http_status_code
        result_response.to_json
      end

      routing.on 'api/v1' do
        routing.on 'cities' do
          routing.is do
            routing.get do
              # GET /cities
              if routing.params.length.zero?
                result = Service::Cities.new.list

                if result.failure?
                  failed = Representer::HttpResponse.new(result.failure)
                  routing.halt failed.http_status_code, failed.to_json
                end

                http_response = Representer::HttpResponse.new(result.value!)
                response.status = http_response.http_status_code
                Representer::CitiesList.new(result.value!.message).to_json
              # GET /cities?
              else
                q_key, q_value = Request::CityQueryParser.new(routing.params).parse.value!

                case q_key
                when 'city_name' # GET /cities?city_name={name}
                  result = Service::Cities.new.find_by_name(q_value)
                when 'city_id' # GET /cities?city_id={id}
                  result = Service::Cities.new.find_by_id(q_value)
                end

                if result.failure?
                  failed = Representer::HttpResponse.new(result.failure)
                  routing.halt failed.http_status_code, failed.to_json
                end

                http_response = Representer::HttpResponse.new(result.value!)
                response.status = http_response.http_status_code
                Representer::CityResult.new(result.value!.message).to_json
              end
            end
          end

          routing.on String do |city_id|
            routing.on 'parks' do
              routing.is do
                # GET /cites/{city_id}/parks
                routing.get do
                  result = Service::Parks.new.find_by_city_id(city_id)

                  if result.failure?
                    failed = Representer::HttpResponse.new(result.failure)
                    routing.halt failed.http_status_code, failed.to_json
                  end

                  http_response = Representer::HttpResponse.new(result.value!)
                  response.status = http_response.http_status_code
                  Representer::ParksList.new(result.value!.message).to_json
                end
              end
            end

            routing.on 'timetable' do
              routing.is do
                # GET /cities/{city_id}/timetable
                routing.get do
                  direction = routing.params['direction']
                  date = routing.params['date']

                  result = Service::Cities.new.find_time(city_id, direction, date)

                  if result.failure?
                    failed = Representer::HttpResponse.new(result.failure)
                    routing.halt failed.http_status_code, failed.to_json
                  end

                  http_response = Representer::HttpResponse.new(result.value!)
                  response.status = http_response.http_status_code
                  Representer::TimesList.new(result.value!.message).to_json
                end
              end
            end
          end
        end

        routing.on 'parks' do
          routing.on String do |park_id|
            # GET /parks/{park_id}
            routing.get do
              result = Service::Parks.new.find_one_by_park_id(park_id)

              if result.failure?
                failed = Representer::HttpResponse.new(result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(result.value!)
              response.status = http_response.http_status_code
              Representer::ParkResult.new(result.value!.message).to_json
            end
          end
        end

        routing.on 'restaurants' do
          routing.on String do |park_id|
            # GET /restaurants/{park_id}?radius={500}
            routing.get do
              radius = routing.params['radius'] || '500'
              type = 'restaurant'

              result = Service::RestaurantAround.new.call({
                park_id: park_id,
                radius: radius,
                type: type
              })

              if result.failure?
                failed = Representer::HttpResponse.new(result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(result.value!)
              response.status = http_response.http_status_code
              Representer::RestaurantsList.new(result.value!.message).to_json
            end
          end
        end

        routing.on 'worker' do
          routing.is do
            # POST /worker/
            routing.post do
              result = JSON.parse(routing.body.read)['park_left']
              puts result

              # message = JSON.parse(routing.body.read)['UpdateTime']
              result_response = Representer::HttpResponse.new(
                Response::ApiResult.new(status: :ok, message: result)
              )
    
              response.status = result_response.http_status_code
              result_response.to_json
            end
          end
        end
      end
    end
  end
end
