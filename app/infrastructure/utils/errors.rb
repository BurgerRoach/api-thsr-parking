# frozen_string_literal: true

module Errors
  # HTTP Error:BadRequest
  class BadRequest < StandardError; end
  # HTTP Error:Unauthorized
  class Unauthorized < StandardError; end
  # HTTP Error:Not found
  class NotFound < StandardError; end
  # HTTP Error: Not Allowed
  class MethodNotAllowed < StandardError; end

  # Options Error
  class OptionsError < StandardError; end

  # ID format Error
  class IDFormatError < StandardError; end

  # Str format Error
  class StrFormatError < StandardError; end
end
