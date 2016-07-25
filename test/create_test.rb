gem 'minitest'      # don't use bundled minitest
require 'minitest/autorun'
require 'minitest/pride'


require_relative '../lib/jruby_art/creators/sketch_writer'

EMACS = <<~CODE
  # frozen_string_literal: false
  require 'jruby_art'
  require 'jruby_art/app'

  Processing::App::SKETCH_PATH = __FILE__.freeze

  class FredSketch < Processing::App
    def settings
      size 200, 200
    end

    def setup
      sketch_title 'Fred Sketch'
    end

    def draw

    end
  end

  FredSketch.new unless defined? $app

CODE

CLASS_SKETCH = <<~CODE
  # frozen_string_literal: false
  
  class FredSketch < Processing::App
    def settings
      size 200, 200
    end

    def setup
      sketch_title 'Fred Sketch'
    end

    def draw

    end
  end

CODE

BARE = <<~CODE
  def settings
    size 200, 200, P2D
  end

  def setup
    sketch_title 'Fred Sketch'
  end

  def draw

  end

CODE

class SketchWriterTest < Minitest::Test

  def test_bare
    name = 'fred_sketch'
    size = %w(200 200 p2d)
    result = BARE.split(/\n/, -1)
    sketch = Sketch.new.bare(name, size)
    sketch.each_with_index do |line, i|
      assert_equal result[i], line
    end
  end

  def test_class
    name = 'fred_sketch'
    size = %w(200 200)
    result = CLASS_SKETCH.split(/\n/, -1)
    class_lines = Sketch.new.class_wrapped(name, size)
    class_lines.each_with_index do |line, i|
      assert_equal result[i], line
    end
  end

  def test_emacs
    name = 'fred_sketch'
    size = %w(200 200)
    result = EMACS.split(/\n/, -1)
    class_lines = Sketch.new.emacs(name, size)
        class_lines.each_with_index do |line, i|
      assert_equal result[i], line
    end
  end
end