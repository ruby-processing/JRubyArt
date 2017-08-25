# frozen_string_literal: false
# A pry shell for live coding.
# Will start with your sketch.
require_relative 'base'
Processing.load_and_run_sketch

class PryException < StandardError
end

MESSAGE = "You need to 'jruby -S gem install pry' for 'live' mode".freeze

if Gem::Specification.find_all_by_name('pry').any?
  require 'pry'
  Processing.app.pry
else
  raise(PryException.new, MESSAGE)
end
