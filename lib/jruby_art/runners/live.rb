# frozen_string_literal: false

# A pry shell for live coding.
# Will start with your sketch.
require_relative 'base'
Processing.load_and_run_sketch

# Custom Exception
class PryException < StandardError
  MESSAGE = "You need to 'jruby -S gem install pry' for 'live' mode".freeze

  def initialize(msg = MESSAGE)
    super
  end
end

raise PryException unless Gem::Specification.find_all_by_name('pry').any?

require 'pry'
Processing.app.pry
