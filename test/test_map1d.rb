# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/jruby_art/helper_methods'

Java::Monkstone::JRLibrary.new.load(JRuby.runtime, false)
# method tests
class Rp5Test < Minitest::Test
  include Processing::HelperMethods
  include Processing::MathTool
  def setup; end

  def test_map1d
    x = [0, 5, 7.5, 10]
    range1 = (0..10)
    range2 = (100..1)
    range3 = (0..10)
    range4 = (5..105)
    assert_in_epsilon(map1d(x[0], range1, range2), 100, 'map to first')
    assert_in_epsilon(map1d(x[1], range1, range2), 50.5, 'map to reversed intermediate')
    assert_in_epsilon(map1d(x[2], range3, range4), 80.0, 'map to intermediate')
    assert_in_epsilon(map1d(x[3], range1, range2), 1, 'map to last')
  end

  def test_p5map # as map1d except not using range input
    x = [0, 5, 7.5, 10]
    range1 = (0..10)
    range2 = (100..1)
    range3 = (0..10)
    range4 = (5..105)
    assert_in_epsilon(p5map(x[0], range1.first, range1.last, range2.first, range2.last), 100)
    assert_in_epsilon(p5map(x[1], range1.first, range1.last, range2.first, range2.last), 50.5)
    assert_in_epsilon(p5map(x[2], range3.first, range3.last, range4.first, range4.last), 80.0)
    assert_in_epsilon(p5map(x[3], range1.first, range1.last, range2.first, range2.last), 1)
  end

  def test_norm
    x = [10, 140, 210]
    start0 = 30
    last0 = 200
    start1 = 0
    last1 = 200
    assert_in_epsilon(norm(x[0], start0, last0), -0.11764705882352941, 'unclamped map')
    assert_in_epsilon(norm(x[1], start1, last1), 0.7, 'map to intermediate')
    assert_in_epsilon(norm(x[2], start1, last1), 1.05, 'unclamped map')
  end

  def test_norm_strict
    x = [10, 140, 210]
    start0 = 30
    last0 = 200
    assert_in_epsilon(norm_strict(x[0], start0, last0), 0, 'clamped map to 0..1.0')
  end

  def test_lerp # behaviour is deliberately different to processing which is unclamped
    x = [0.5, 0.8, 2.0]
    start0 = 300
    last0 = 200
    start1 = 0
    last1 = 200
    assert_in_epsilon(lerp(start0, last0, x[0]), 250, 'produces a intermediate value of a reversed range')
    assert_in_epsilon(lerp(start1, last1, x[1]), 160, 'lerps tp an intermediate value')
    assert_in_epsilon(lerp(start1, last1, x[2]), 200, 'lerps to the last value of a range')
  end

  def test_constrain
    x = [15, 2_500, -2_500]
    start1 = 0
    last1 = 200
    assert_in_epsilon(constrain(x[0], start1, last1), 15)
    assert_in_epsilon(constrain(x[1], start1, last1), 200)
    assert_in_epsilon(constrain(x[2], start1, last1), 0)
  end
end
