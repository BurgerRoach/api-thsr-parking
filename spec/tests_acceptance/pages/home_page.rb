# frozen_string_literal: true

# Page object for home page
class HomePage
  include PageObject

  page_url THSRParking::App.config.APP_HOST

  button(:start_button, id: 'start')
  button(:search_button, id: 'search')
  img(:background_image, id: 'image')
  a(:first_active_item, id: 'active_item')

  def check_image
    background_image
  end

  def check_active_item
    first_active_item
  end
end
