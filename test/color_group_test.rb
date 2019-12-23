# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../library/color_group/color_group'

Java::Monkstone::JRLibrary.load(JRuby.runtime)
java_import Java::Monkstone::ColorUtil

PALETTE = %w[#FFFFFF #FF0000 #0000FF].freeze
COLORS = [16_777_215, 16_711_680, 255].to_java(:int)

class ColorGroupTest < Minitest::Test
  def test_new
    group = ColorGroup.new(COLORS)
    assert group.is_a? ColorGroup
  end

  def test_web_array
    group = ColorGroup.from_web_array(PALETTE)
    assert group.is_a? ColorGroup
  end

  def test_ruby_string
    p5array = [16_777_215, 16_711_680, 255]
    group = ColorGroup.new(COLORS)
    ruby_string = "%w[#FFFFFF #FF0000 #0000FF]\n"
    result = group.ruby_string
    assert_equal(result, ruby_string)
  end
end
