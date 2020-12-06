# frozen_string_literal: true

require 'yaml'
require_relative '../orms/park_orm'

module THSRParking
  module DatabaseScript
    # Database init data scripts for Parks
    class Parks
      def initialize(data = nil)
        if data
          @data = data
        else
          file_path = 'app/infrastructure/database/scripts/data/parks.yml'
          @data = YAML.load_file(file_path)
        end
      end

      def init
        @data.each do |item|
          Database::ParkOrm.find_or_create(item)
        end
      end
    end
  end
end
