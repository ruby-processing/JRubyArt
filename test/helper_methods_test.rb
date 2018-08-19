require_relative 'test_helper'
require_relative '../lib/jruby_art/helper_methods'

Java::Monkstone::JRLibrary.new.load(JRuby.runtime, false)

include Processing::HelperMethods
include MathTool

Dir.chdir(File.dirname(__FILE__))

class HelperMethodsTest < Minitest::Test

 ARRAY = %w(albatross dog horse)
 def test_hex_color
    col_double = 0.5
    hexcolor = 0xFFCC6600
    dodgy_hexstring = '*56666'
    hexstring = '#CC6600'
    assert hex_color(col_double) == 0.5, 'double as a color'
    assert hex_color(hexcolor) == -3381760, 'hexadecimal fixnum color'
    assert hex_color(hexstring) == -3381760, 'hexadecimal string color'
    assert_raises(StandardError, 'Dodgy Hexstring') do
      hex_color(dodgy_hexstring)
    end
    assert_raises(StandardError, 'Dodgy Color Conversion') do
      hex_color([])
    end
  end

  def test_dist
    ax, ay, bx, by = 0, 0, 1.0, 1.0
    assert_in_epsilon(dist(ax, ay, bx, by), Math.sqrt(2), epsilon = 0.0001, msg = '2D distance')
    by = 0.0
    assert_in_epsilon(dist(ax, ay, bx, by), 1.0, epsilon = 0.0001, msg = 'when y dimension is zero')
    ax, ay, bx, by = 0, 0, 0.0, 0.0
    assert_in_epsilon(dist(ax, ay, bx, by), 0.0, epsilon = 0.0001, msg = 'when x and y dimension are zero')
    ax, ay, bx, by = 1, 1, -2.0, -3.0
    assert_in_epsilon(dist(ax, ay, bx, by), 5.0, epsilon = 0.0001, msg = 'classic triangle dimensions')
    ax, ay, bx, by, cx, cy = -1, -1, 100, 2.0, 3.0, 100
    assert_in_epsilon(dist(ax, ay, bx, by, cx, cy), 5.0, epsilon = 0.0001, msg = 'classic triangle dimensions')
    ax, ay, bx, by, cx, cy = 0, 0, -1.0, -1.0, 0, 0
    assert_in_epsilon(dist(ax, ay, bx, by, cx, cy), Math.sqrt(2), epsilon = 0.0001, msg = '2D distance')
    ax, ay, bx, by, cx, cy = 0, 0, 0.0, 0.0, 0, 0
    assert_in_epsilon(dist(ax, ay, bx, by, cx, cy), 0.0)
    ax, ay, bx, by, cx, cy = 0, 0, 1.0, 0.0, 0, 0
    assert_in_epsilon(dist(ax, ay, bx, by, cx, cy), 1.0, epsilon = 0.0001, msg = 'when x and z dimension are zero')
  end

  def test_min
    assert_equal(min(*ARRAY), 'albatross')
  end

  def test_max
    assert_equal(max(*ARRAY), 'horse')
  end
end
