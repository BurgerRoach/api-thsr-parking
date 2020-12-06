# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:city) do
      primary_key :id

      String      :city_id, unique: true, null: false
      String      :name, null: false
      String      :latitude, null: false
      String      :longitude, null: false
      DateTime    :created_at
      DateTime    :updated_at
    end
  end
end
