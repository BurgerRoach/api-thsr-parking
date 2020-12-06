# frozen_string_literal: true

require_relative '../helpers/acceptance_helper'
require_relative 'pages/home_page'

require 'headless'
require 'watir'

describe 'Acceptance Tests' do
  include ResultPage::PageFactory

  DatabaseHelper.setup_database_cleaner

  before do
    DatabaseHelper.wipe_database
    @headless = Headless.new
    @browser = Watir::Browser.new
  end

  after do
    @browser.close
    @headless.destroy
  end

  describe 'Visit Result page' do
    it '(HAPPY) should show current result' do
      # GIVEN: user press search button
      # WHEN: user go to result page
      visit ResultPage do |page|
        # THEN: they should result
        _(page.check_result.exist?).must_equal true
      end
    end
  end 
end
