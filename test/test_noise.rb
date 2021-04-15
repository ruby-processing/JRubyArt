# frozen_string_literal: true

require_relative 'test_helper'
java_import 'monkstone.noise.Noise'
java_import 'monkstone.noise.NoiseGenerator'
java_import 'monkstone.noise.NoiseMode'
java_import 'monkstone.noise.OpenSimplex2F'
java_import 'monkstone.noise.OpenSimplex2S'

# method tests
class NoiseTest < Minitest::Test

  attr_reader :generator

  def setup
    @generator = NoiseGenerator.new
  end

  def test_noise_mode
    mode = NoiseMode::DEFAULT
    assert_equal 'Fast OpenSimplex2', mode.description
  end

  def test_noise_generator
    mode = NoiseMode::OPEN_SMOOTH
    assert_equal NoiseMode::DEFAULT, generator.noise_mode
    generator.noise_mode mode
    assert_equal mode, generator.noise_mode
  end

  def test_terrain
    fast_terrain = NoiseMode::FAST_TERRAIN
    generator.noise_mode fast_terrain
    assert_equal fast_terrain, generator.noise_mode
    smooth_terrain = NoiseMode::SMOOTH_TERRAIN
    generator.noise_mode smooth_terrain
    assert_equal smooth_terrain, generator.noise_mode
  end

  def test_noise
    assert (-1.0..1.0).include?(generator.noise(2))
    assert (-1.0..1.0).include?(generator.noise(2, 3))
    assert (-1.0..1.0).include?(generator.noise(1, 2, 3))
    assert (-1.0..1.0).include?(generator.noise(1, 2, 3, 4))
  end
end
