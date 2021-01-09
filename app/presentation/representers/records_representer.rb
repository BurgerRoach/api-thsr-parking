# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'record_representer'

module THSRParking
  module Representer
    # Represents list of restaurants for API output
    class RecordsList < Roar::Decorator
      include Roar::JSON

      collection :records, extend: Representer::Record,class: OpenStruct
    end
  end
end
