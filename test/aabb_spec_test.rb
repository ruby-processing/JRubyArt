# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/jruby_art/helpers/aabb'

Java::Monkstone::JRLibrary.new.load(JRuby.runtime, false)

class MathToolTest < Minitest::Test
  def test_aabb_new
    x = 1.0000001
    y = 1.01
    a = Vec2D.new(x, y)
    assert AaBb.new(center: Vec2D.new, extent: a).is_a? AaBb
    x0 = -4
    y0 = -4
    a = Vec2D.new(x0, y0)
    b = a *= -1
    assert AaBb.from_min_max(min: a, max: b).is_a? AaBb
    x = 1.0000001
    y = 1.01
    a = AaBb.new(center: Vec2D.new, extent: Vec2D.new(x, y))
    a.position(Vec2D.new(4, 6))
    assert a.center == Vec2D.new(4, 6)
    x = 1.0000001
    y = 1.01
    a = AaBb.new(center: Vec2D.new, extent: Vec2D.new(x, y))
    a.position(Vec2D.new(4, 6)) { false }
    assert a.center == Vec2D.new
  end
end
