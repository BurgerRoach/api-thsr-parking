# frozen_string_literal: true

# Page object for home page
class ResultPage
  include PageObject

  page_url THSRParking::App.config.APP_HOST
  page_url "#{THSRParking::App.config.APP_HOST}/result/city?city_name<%= params[:city_name]%>"

  section(:result_parking, id: 'result_section')

  def check_result
    result_parking
  end
end