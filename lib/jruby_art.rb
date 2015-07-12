# Ruby-Processing is for Code Art.
# Send suggestions, ideas, and hate-mail to mamba2928 [at] gmail.com
# Also, send samples and libraries.
unless defined? K9_ROOT
  $LOAD_PATH << File.expand_path(File.dirname(__FILE__))
  K9_ROOT = File.expand_path(File.dirname(__FILE__) + '/../')
end

SKETCH_ROOT ||= Dir.pwd

require 'jruby_art/version'
require 'jruby_art/helpers/numeric'
require 'jruby_art/helpers/range'

# The top-level namespace, a home for all Ruby-Processing classes.
module Processing
  require 'jruby_art/runner'
end
