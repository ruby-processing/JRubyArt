# frozen_string_literal: true
# JRubyArt is for Code Art.
# Send suggestions, ideas, and hate-mail to mamba2928 [at] gmail.com
# Also, send samples and libraries.
unless defined? K9_ROOT
  $LOAD_PATH << File.expand_path(File.dirname(__FILE__))
  K9_ROOT = File.expand_path(File.dirname(__FILE__) + '/../')
end

SKETCH_ROOT ||= Dir.pwd

require 'jruby_art/version'
require 'jruby_art/helpers/numeric'

# The top-level namespace, a home for all JRubyArt classes.
module Processing
  require 'jruby_art/runner'
end
