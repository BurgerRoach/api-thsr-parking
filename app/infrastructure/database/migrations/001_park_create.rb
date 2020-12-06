# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:parks) do
      primary_key :id
      # foreign_key :city_id

      String      :park_origin_id, unique: true, null: false
      String      :city_id, null: false
      String      :latitude, null: false
      String      :longitude, null: false
      String      :city, null: false
      String      :name, null: false
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
