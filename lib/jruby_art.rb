# Ruby-Processing is for Code Art.
# Send suggestions, ideas, and hate-mail to mamba2928 [at] gmail.com
# Also, send samples and libraries.
unless defined? RP5_ROOT
  $LOAD_PATH << File.expand_path(File.dirname(__FILE__))
  RP5_ROOT = File.expand_path(File.dirname(__FILE__) + '/../')
end

SKETCH_ROOT ||= Dir.pwd

require 'jruby_art/version'
require 'jruby_art/helpers/numeric'
require 'jruby_art/helpers/range'

# The top-level namespace, a home for all Ruby-Processing classes.
module Processing

  # Autoload a number of path/constants that we may end up using.
  # mri ruby does not understand ** require 'java' ** and we may otherwise call
  # it from mri ruby without lazy path loading of autoload
  # NB: autoload was slated for possible removal by ruby-2.2 never happened
  autoload :App,                  'jruby_art/app'
  autoload :Runner,               'jruby_art/runner'
  autoload :Watcher,              'jruby_art/runners/watch'
end
