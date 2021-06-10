require_relative 'test_helper'

Java::Monkstone::JRLibrary.new.load(JRuby.runtime, false)
# method tests
class NoiseTest < Minitest::Test
  include FastNoise

  VALS = [0.4, 0.5, 4, 5].freeze

  def test_noise1d
    assert self.respond_to? :noise
    result = VALS.map { |x| noise(x) }
    assert result.all? { |x| (-1.0..1.0).include?(x) }
    assert VALS.length == result.uniq.length
  end

  def test_noise2d
    result = VALS.map { |x| noise(x, Math.sin(x)) }
    assert result.all? { |x| (-1.0..1.0).include?(x) }
    assert VALS.length == result.uniq.length
  end

  def test_noise3d
    result = VALS.map { |x| noise(x, Math.sin(x), Math.cos(x)) }
    assert result.all? { |x| (-1.0..1.0).include?(x) }
    assert VALS.length == result.uniq.length
  end

  def test_noise4d
    result = VALS.map { |x| noise(x, rand, Math.sin(x), Math.cos(x)) }
    assert result.all? { |x| (-1.0..1.0).include?(x) }
    assert VALS.length == result.uniq.length
  end

  def test_tnoise2d
    result = VALS.map { |x| tnoise(x, Math.sin(x)) }
    assert result.all? { |x| (-1.0..1.0).include?(x) }
    assert VALS.length == result.uniq.length
  end

  def test_tnoise3d
    result = VALS.map { |x| tnoise(x, Math.sin(x), Math.cos(x)) }
    assert result.all? { |x| (-1.0..1.0).include?(x) }
    assert VALS.length == result.uniq.length
  end

  def test_tnoise4d
    result = VALS.map { |x| tnoise(x, rand, Math.sin(x), Math.cos(x)) }
    assert result.all? { |x| (-1.0..1.0).include?(x) }
    assert VALS.length == result.uniq.length
  end
end
