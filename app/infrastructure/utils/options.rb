# frozen_string_literal: true

module THSRParking
  module THSR
    # THSR Options
    class Options
      def initialize
        @option_keys = %i[service_status service_available_level charge_status]
      end

      def invalid_options?(opts)
        return false if opts.empty?

        opts.each_key { |k| return true unless @option_keys.include?(k) == true }
        false
      end
    end
  end
end
