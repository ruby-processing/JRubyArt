# frozen_string_literal: true

# JRubyArt is for Code Art.
# Send suggestions, ideas, and hate-mail to mamba2928 [at] gmail.com
# Also, send samples and libraries.
unless defined? K9_ROOT
  $LOAD_PATH << File.dirname(__dir__)
  K9_ROOT = File.dirname(__dir__)
end

require "#{K9_ROOT}/lib/jruby_art/version"
require "#{K9_ROOT}/lib/jruby_art/helpers/numeric"
# inherited from ruby-processing, we could probably re-factor this but since
# SKETCH_ROOT is used before instance of sketch is created leave alone.
SKETCH_ROOT ||= Dir.pwd

# The top-level namespace, a home for all JRubyArt classes.
module Processing
  require "#{K9_ROOT}/lib/jruby_art/runner"
end
