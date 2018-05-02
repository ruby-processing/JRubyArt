require_relative 'test_helper'
require_relative '../lib/jruby_art/creators/sketch_writer'

EMACS = <<~CODE
# frozen_string_literal: false
require 'jruby_art'
require 'jruby_art/app'

Processing::App::SKETCH_PATH = __FILE__.freeze

class FredSketch < Processing::App
  def settings
    size 200, 200, P2D
  end

  def setup
    sketch_title 'Fred Sketch'
  end

  def draw

  end
end

FredSketch.new if Processing.app.nil?

CODE

CLASS_SKETCH = <<~CODE
# frozen_string_literal: false

class FredSketch < Processing::App
  def settings
    size 200, 200, P2D
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
  ParamMethods = Struct.new(:name, :class_name, :sketch_title, :sketch_size)

  def setup
    @param = ParamMethods.new(
      'fred_sketch',
      'FredSketch',
      "sketch_title 'Fred Sketch'",
      'size 200, 200, P2D'
    )
  end

  def test_parameter_new
    param = SketchParameters.new(name: 'fred_sketch', args: %w(200 200 p2d))
    assert_equal "sketch_title 'Fred Sketch'", param.sketch_title
    assert_equal 'size 200, 200, P2D', param.sketch_size
    assert_equal 'FredSketch', param.class_name
  end

  def test_bare
    result = BARE.split(/\n/, -1)
    sketch = BareSketch.new(@param).code
    sketch.each_with_index do |line, i|
      assert_equal result[i], line
    end
  end

  def test_class
    result = CLASS_SKETCH.split(/\n/, -1)
    sketch = ClassSketch.new(@param).code
    sketch.each_with_index do |line, i|
      assert_equal result[i], line
    end
  end

  def test_emacs
    result = EMACS.split(/\n/, -1)
    sketch = EmacsSketch.new(@param).code
    sketch.each_with_index do |line, i|
      assert_equal result[i], line
    end
  end
end
