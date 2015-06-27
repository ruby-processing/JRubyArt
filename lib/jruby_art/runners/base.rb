# -*- encoding : utf-8 -*-

SKETCH_PATH ||= ARGV.shift
SKETCH_ROOT ||= File.dirname(SKETCH_PATH)

require_relative '../../jruby_art'
require_relative '../../jruby_art/app'

# More processing module
module Processing
  # For use with "bare" sketches that don't want to define a class or methods
  BARE_WRAP = <<-EOS
  class Sketch < Processing::App
    %s
  end
  EOS

  NAKED_WRAP = <<-EOS
  class Sketch < Processing::App
    def setup
      sketch_title 'Naked Sketch'
      %s
      no_loop
    end

    def settings
      size(DEFAULT_WIDTH, DEFAULT_HEIGHT)
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
      Processing::App.sketch_class.new unless $app
      return
    end
    code = no_methods ? format(NAKED_WRAP, source) : format(BARE_WRAP, source)
    Object.class_eval code, SKETCH_PATH, -1
    Processing::App.sketch_class.new
  end

  # Read in the sketch source code. Needs to work both online and offline.
  def self.read_sketch_source
    File.read(SKETCH_PATH)
  end
end
