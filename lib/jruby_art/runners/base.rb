# frozen_string_literal: true
SKETCH_PATH ||= ARGV.shift
SKETCH_ROOT ||= File.absolute_path(File.dirname(SKETCH_PATH))

# we can safely require app.rb as we are using a jruby runtime
require_relative '../app'

# More processing module
module Processing
  # For use with "bare" sketches that don't want to define a class or methods
  BARE_WRAP = <<-EOS.freeze
  class Sketch < Processing::App
    %s
  end
  EOS

  NAKED_WRAP = <<-EOS.freeze
  class Sketch < Processing::App
    def setup
      sketch_title '%s'
      %s
      no_loop
    end

    def settings
      size(%d, %d)
    end
  end
  EOS

  # This method is the common entry point to run a sketch, bare or complete.
  def self.load_and_run_sketch
    source = read_sketch_source
    wrapped = !source.match(/^[^#]*< Processing::App/).nil?
    no_methods = source.match(/^[^#]*(def\s+setup|def\s+draw)/).nil?
    if wrapped
      load SKETCH_PATH
      Processing::App.sketch_class.new unless Processing.app
      return
    end
    name = RP_CONFIG.fetch('sketch_title', 'Naked Sketch')
    width = RP_CONFIG.fetch('width', 200)
    height = RP_CONFIG.fetch('height', 200)
    code = no_methods ? format(NAKED_WRAP, name, source, width, height) : format(BARE_WRAP, source)
    Object.class_eval code, SKETCH_PATH, -1
    Processing::App.sketch_class.new unless Processing.app
  end

  # Read in the sketch source code. Needs to work both online and offline.
  def self.read_sketch_source
    File.read(SKETCH_PATH)
  end
end
