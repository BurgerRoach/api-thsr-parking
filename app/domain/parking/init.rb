# frozen_string_literal: true

%w[values entities mappers repositories]
  .each do |folder|
    require_relative "#{folder}/init"
  end
