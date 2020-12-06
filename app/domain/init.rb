# frozen_string_literal: true

folders = %w[city restaurant parking]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
