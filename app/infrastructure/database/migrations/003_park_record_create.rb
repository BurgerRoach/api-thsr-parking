# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:park_records) do
      primary_key :id

      String      :park_origin_id, null: false
      Integer     :available_spaces, null: false
      DateTime    :update_time, null:false
    end
  end
end
