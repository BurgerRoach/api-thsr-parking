# frozen_string_literal: true

require 'sequel'

Sequel.migration do
  change do
    create_table(:park_records) do
      primary_key :id

      String      :park_origin_id, unique: true, null: false
      Integer     :availalbe_avg, null: false
      DateTime    :start_at
      DateTime    :end_at
    end
  end
end
