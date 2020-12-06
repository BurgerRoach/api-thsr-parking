# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

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
            # GET /cities
            # GET /cities?city_id={}
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

              else
                q_key, q_value = Request::CityQueryParser.new(routing.params).parse.value!

                # GET /cities?city_name=
                if q_key == 'city_name'
                  result = Service::Cities.new.find_by_name(q_value)

                  if result.failure?
                    failed = Representer::HttpResponse.new(result.failure)
                    routing.halt failed.http_status_code, failed.to_json
                  end

                  http_response = Representer::HttpResponse.new(result.value!)
                  response.status = http_response.http_status_code
                  Representer::CityResult.new(result.value!.message).to_json
                end

                # GET /cities?city_id=
                if q_key == 'city_id'
                  result = Service::Cities.new.find_by_id(q_value)

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
          end
        end
      end
    end
  end
end
