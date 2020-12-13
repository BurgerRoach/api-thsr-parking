# frozen_string_literal: true

require_relative '../helpers/acceptance_helper'
require_relative 'pages/home_page'

require 'headless'
require 'watir'

describe 'Acceptance Tests' do
  include PageObject::PageFactory

  DatabaseHelper.setup_database_cleaner

  before do
    DatabaseHelper.wipe_database
    # @headless = Headless.new
    @browser = Watir::Browser.new
  end

  after do
    @browser.close
    # @headless.destroy
  end

  describe 'Visit Home page' do
    it '(HAPPY) should connect to the right url' do
      # GIVEN: user enter the url
      # WHEN: go to the url
      visit HomePage do |page|
        # THEN: they should go to the THSRParking url
        _(page.url).include? THSRParking
      end
    end

    it '(HAPPY) should see background image' do
      # GIVEN: user go to homepage
      # WHEN: user in the home page
      visit HomePage do |page|
        # THEN: they should see background image
        _(page.check_image.exist?).must_equal true
      end
    end

    it '(HAPPY) should see important buttons' do
      # GIVEN: user go to homepage
      # WHEN: user in the home page
      visit HomePage do |page|
        # THEN: they should see important buttons
        _(page.start_button_element.present?).must_equal true
        _(page.search_button_element.present?).must_equal true
      end
    end

    it '(HAPPY) should see active item' do
      # GIVEN: user go to homepage
      # WHEN: user in the home page
      visit HomePage do |page|
        # THEN: they should see active item
        _(page.check_active_item.exist?).must_equal true
      end
    end
  end
end
