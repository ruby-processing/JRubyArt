# -*- encoding : utf-8 -*-

SKETCH_PATH ||= ARGV.shift
SKETCH_ROOT ||= File.dirname(SKETCH_PATH)

require_relative '../jruby_art'
require_relative '../jruby_art/'
require_relative '../jruby_art/helpers/string'

module Processing
  # For use with "bare" sketches that don't want to define a class or methods
  BARE_TEMPLATE = <<-EOS
  require 'jruby_art'

  class Sketch < %s
    %s
  end

  Sketch.new(title: '%s')
  EOS
  
  NAKED_TEMPLATE = <<-EOS
  require 'jruby_art'

  class Sketch < Processing::App

    def setup
      %s
      no_loop
    end
  end

  Sketch.new(title: '%s')
  EOS

  # This method is the common entry point to run a sketch, bare or complete.
  def self.load_and_run_sketch
    source = read_sketch_source
    has_sketch = !source.match(/^[^#]*< Processing::App/).nil?
    has_methods = !source.match(/^[^#]*(def\s+setup|def\s+draw)/).nil?    
    return load File.join(SKETCH_ROOT, SKETCH_PATH) if has_sketch
    title = File.basename(SKETCH_PATH).sub(/(\.rb)$/, '').titleize
    if has_methods
      default = source.match(/P(2|3)D/)      
      mode = default ? 'Processing::App' : 'Processing::AppGL'
      code = format(BARE_TEMPLATE, mode, source, title)
    else     
      code = format(NAKED_TEMPLATE, source, title)
    end
    Object.class_eval code, SKETCH_PATH, -1
  end

  # Read in the sketch source code. Needs to work both online and offline.
  def self.read_sketch_source
    File.read(SKETCH_PATH)
  end
end

Processing.load_and_run_sketch

