# frozen_string_literal: true

module THSRParking
  module Value
    # remain value
    class Remain < SimpleDelegator
      def initialize(city)
        @entity = super(city).parks
      end

      # def nothing_left?
      #   @entity.each do |obj|
      #     return false if obj.available_spaces > 0
      #   end
      #   true
      # end
    end
  end
end
