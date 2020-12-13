# frozen_string_literal: true

module THSRParking
  module Response
    # List of parks
    ParksList = Struct.new(:update_time, :parks)
  end
end
