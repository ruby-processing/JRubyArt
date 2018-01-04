require_relative 'test_helper'
require_relative '../lib/rpextras'

Java::Monkstone::JRLibrary.load(JRuby.runtime)


Dir.chdir(File.dirname(__FILE__))

class VecmathTest < Minitest::Test

  # duck for Vec2D constructor
  Point = Struct.new(:x, :y)
  # duck for Vec3D constructor
  Point3 = Struct.new(:x, :y, :z)
  # non-duck to test fail
  Pointless = Struct.new(:a, :b)
  # non-duck to test fail
  Pointless3 = Struct.new(:a, :b, :c)
  def setup

  end

  def test_equals
    x, y = 1.0000001, 1.01
    a = Vec2D.new(x, y)
    assert_equal(a.to_a, [x, y], 'Failed to return Vec2D as an Array')
  end

  def test_not_equals
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    refute_equal(a, b, 'Failed equals false')
  end

  def test_copy_equals
    x, y = 1.0000001, 1.01
    a = Vec2D.new(x, y)
    b = a.copy
    assert_equal(a.to_a, b.to_a, 'Failed deep copy')
  end

  def test_constructor_float
    val = Point.new(1.0, 8.0) # duck type
    expected = Vec2D.new(val)
    assert_equal(expected, Vec2D.new(1.0, 8.0), 'Failed duck type constructor floats')
  end

  def test_constructor_fixnum
    val = Point.new(1, 8) # duck type fixnum
    expected = Vec2D.new(val)
    assert_equal(expected, Vec2D.new(1.0, 8.0), 'Failed duck type constructor fixnum')
  end

  def test_failed_duck_type
    val = Pointless.new(1.0, 8.0) # non duck type
    assert_raises TypeError do
      Vec2D.new(val)
    end
  end

  def test_copy_not_equals
    x, y = 1.0000001, 1.01
    a = Vec2D.new(x, y)
    b = a.copy
    b *= 0
    refute_equal(a.to_a, b.to_a, 'Failed deep copy')
  end

  def test_equals_when_close
    a = Vec2D.new(3.0000000, 5.00000)
    b = Vec2D.new(3.0000000, 5.000001)
    assert_equal(a, b, 'Failed to return equal when v. close')
  end

  def test_sum
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    c = Vec2D.new(9, 12)
    assert_equal(a + b, c, 'Failed to sum vectors')
  end

  def test_subtract
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    c = Vec2D.new(-3, -2)
    assert_equal(a - b, c, 'Failed to subtract vectors')
  end

  def test_multiply
    a = Vec2D.new(3, 5)
    b = 2
    c = a * b
    d = Vec2D.new(6, 10)
    assert_equal(c, d, 'Failed to multiply vector by scalar')
  end

  def test_divide
    a = Vec2D.new(3, 5)
    b = 2
    c = Vec2D.new(1.5, 2.5)
    d = a / b
    assert_equal(c, d, 'Failed to divide vector by scalar')
  end

  def test_dot
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    assert_in_epsilon(a.dot(b), 53, 0.001, 'Failed to dot product')
  end

  def test_self_dot
    a = Vec2D.new(3, 5)
    assert_in_epsilon(a.dot(a), 34, 0.001, 'Failed self dot product')
  end

  def test_from_angle
    a = Vec2D.from_angle(Math::PI * 0.75)
    assert_equal(a, Vec2D.new(-1 * Math.sqrt(0.5), Math.sqrt(0.5)), 'Failed to create vector from angle')
  end

  def test_random
    a = Vec2D.random
    assert a.kind_of? Vec2D
    assert_in_epsilon(a.mag, 1.0)
  end

  def test_assign_value
    a = Vec2D.new(3, 5)
    a.x = 23
    assert_equal(a.x, 23, 'Failed to assign x value')
  end

  def test_mag
    a = Vec2D.new(-3, -4)
    assert_in_epsilon(a.mag, 5, 0.001,'Failed to return magnitude of vector')
  end

  def test_mag_variant
    a = Vec2D.new(3.0, 2)
    b = Math.sqrt(3.0**2 + 2**2)
    assert_in_epsilon(a.mag, b, 0.001, 'Failed to return magnitude of vector')
  end

  def test_mag_zero_one
    a = Vec2D.new(-1, 0)
    assert_in_epsilon(a.mag, 1, 0.001, 'Failed to return magnitude of vector')
  end

  def test_dist
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    assert_in_epsilon(a.dist(b), Math.sqrt(3.0**2 + 2**2), 0.001, 'Failed to return distance between two vectors')
  end

  def test_lerp
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    assert_equal(a.lerp(b, 0.5), Vec2D.new(2, 2), 'Failed to return lerp between two vectors')
  end

  def test_lerp_unclamped
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    assert_equal(a.lerp(b, 5), Vec2D.new(11, 11), 'Failed to return lerp between two vectors')
  end

    def test_lerp!
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    a.lerp!(b, 0.5)
    assert_equal(a, Vec2D.new(2, 2), 'Failed to return lerp! between two vectors')
  end

  def test_lerp_unclamped!
    a = Vec2D.new(1, 1)
    b = Vec2D.new(3, 3)
    a.lerp!(b, 5)
    assert_equal(a, Vec2D.new(11, 11), 'Failed to return lerp! between two vectors')
  end

  def test_set_mag
    a = Vec2D.new(1, 1)
    assert_equal(a.set_mag(Math.sqrt(32)), Vec2D.new(4, 4), 'Failed to set_mag vector')
  end

  def test_set_mag_block
    a = Vec2D.new(1, 1)
    assert_equal(a.set_mag(Math.sqrt(32)) { true }, Vec2D.new(4, 4), 'Failed to set_mag_block true vector')
  end

  def test_set_mag_block_false
    a = Vec2D.new(1, 1)
    assert_equal(a.set_mag(Math.sqrt(32)) { false }, Vec2D.new(1, 1), 'Failed to set_mag_block true vector')
  end

  def test_plus_assign
    a = Vec2D.new(3, 5)
    b = Vec2D.new(6, 7)
    a += b
    assert_equal(a, Vec2D.new(9, 12), 'Failed to += assign')
  end

  def test_normalize
    a = Vec2D.new(3, 5)
    b = a.normalize
    assert_in_epsilon(b.mag, 1, 0.001, 'Failed to return a normalized vector')
  end

  def test_normalize!
    a = Vec2D.new(3, 5)
    a.normalize!
    assert_in_epsilon(a.mag, 1, 0.001, 'Failed to return a normalized! vector')
  end

  def test_heading
    a = Vec2D.new(1, 1)
    assert_in_epsilon(a.heading, Math::PI / 4.0, 0.001, 'Failed to return heading in radians')
  end

  def test_rotate
    x, y = 20, 10
    b = Vec2D.new(x, y)
    a = b.rotate(Math::PI / 2)
    assert_equal(a, Vec2D.new(-10, 20), 'Failed to rotate vector by scalar radians')
  end

  def test_hash_index
    x, y = 10, 20
    b = Vec2D.new(x, y)
    assert_equal(b[:x], x, 'Failed to hash index')
  end

  def test_hash_set
    x = 10
    b = Vec2D.new
    b[:x] = x
    assert_equal(b, Vec2D.new(x, 0), 'Failed to hash assign')
  end

  def test_inspect
    a = Vec2D.new(3, 2.000000000000001)
    assert_equal(a.inspect, 'Vec2D(x = 3.0000, y = 2.0000)')
  end

  def test_array_reduce
    array = [Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(1, 2)]
    sum = array.reduce(Vec2D.new) { |c, d| c + d }
    assert_equal(sum, Vec2D.new(12, 6))
  end

  def test_array_zip
    one = [Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(1, 2)]
    two = [Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(1, 2)]
    zipped = one.zip(two).flatten
    expected = [Vec2D.new(1, 2), Vec2D.new(1, 2), Vec2D.new(10, 2), Vec2D.new(10, 2), Vec2D.new(1, 2), Vec2D.new(1, 2)]
    assert_equal(zipped, expected)
  end

  def test_cross_area # NB: the sign might be negative
    a = Vec2D.new(200, 0)
    b = Vec2D.new(0, 200)
    # Expected result is an area, twice that of the triangle created by the vectors
    assert_equal((a).cross(b).abs, 40_000.0, 'Failed area test using 2D vector cross product')
  end

  def test_cross_non_zero # Could be used to calculate area of triangle
    a = Vec2D.new(40, 40)
    b = Vec2D.new(40, 140)
    c = Vec2D.new(140, 40)
    assert_equal((a - b).cross(b - c).abs / 2, 5_000.0, 'Failed area calculation using 2D vector cross product')
  end

  def test_cross_zero # where a, b, c are collinear area == 0
    a = Vec2D.new(0, 0)
    b = Vec2D.new(100, 100)
    c = Vec2D.new(200, 200)
    # see http://mathworld.wolfram.com/Collinear.html for details
    assert((a - b).cross(b - c).zero?, 'Failed collinearity test using 2D vector cross product')
  end

  def test_equals3
    x, y, z = 1.0000001, 1.01, 0.0
    a = Vec3D.new(x, y)
    assert_equal(a.to_a, [x, y, z], 'Failed to return Vec3D as an Array')
  end

  def test_constructor_float3
    val = Point3.new(1.0, 8.0, 7.0) # duck type
    expected = Vec3D.new(val)
    assert_equal(expected, Vec3D.new(1.0, 8.0, 7.0), 'Failed duck type constructor floats')
  end

  def test_constructor_fixnum3
    val = Point3.new(1, 8, 7) # duck type fixnum
    expected = Vec3D.new(val)
    assert_equal(expected, Vec3D.new(1.0, 8.0, 7.0), 'Failed duck type constructor fixnum')
  end

  def test_failed_duck_type3
    val = Pointless3.new(1.0, 8.0, 7.0) # non duck type
    assert_raises TypeError do
      Vec3D.new(val)
    end
  end

  def test_not_equals3
    a = Vec3D.new(3, 5, 1)
    b = Vec3D.new(6, 7, 1)
    refute_equal(a, b, 'Failed equals false')
  end

  def test_copy_equals3
    x, y, z = 1.0000001, 1.01, 1
    a = Vec3D.new(x, y, z)
    b = a.copy
    assert_equal(a.to_a, b.to_a, 'Failed deep copy')
  end

  def test_copy_not_equals3
    x, y, z = 1.0000001, 1.01, 6.0
    a = Vec3D.new(x, y, z)
    b = a.copy
    b *= 0
    refute_equal(a.to_a, b.to_a, 'Failed deep copy')
  end

  def test_equals_when_close3
    a = Vec3D.new(3.0000000, 5.00000, 2)
    b = Vec3D.new(3.0000000, 5.000001, 2)
    assert_equal(a, b, 'Failed to return equal when v. close')
  end

  def test_sum3
    a = Vec3D.new(3, 5, 1)
    b = Vec3D.new(6, 7, 1)
    c = Vec3D.new(9, 12, 2)
    assert_equal(a + b, c, 'Failed to sum vectors')
  end

  def test_subtract3
    a = Vec3D.new(3, 5, 0)
    b = Vec3D.new(6, 7, 1)
    c = Vec3D.new(-3, -2, -1)
    assert_equal(a - b, c, 'Failed to subtract vectors')
  end

  def test_multiply3
    a = Vec3D.new(3, 5, 1)
    b = 2
    c = a * b
    d = Vec3D.new(6, 10, 2)
    assert_equal(c, d, 'Failed to multiply vector by scalar')
  end

  def test_divide3
    a = Vec3D.new(3, 5, 4)
    b = 2
    c = Vec3D.new(1.5, 2.5, 2)
    d = a / b
    assert_equal(c, d, 'Failed to divide vector by scalar')
  end

  def test_random3
    a = Vec3D.random
    assert a.kind_of? Vec3D
    assert_in_epsilon(a.mag, 1.0)
  end

  def test_assign_value3
    a = Vec3D.new(3, 5)
    a.x=23
    assert_equal(a.x, 23, 'Failed to assign x value')
  end

  def test_mag3
    a = Vec3D.new(-3, -4)
    assert_equal(a.mag, 5, 'Failed to return magnitude of vector')
  end

  def test_mag_variant3
    a = Vec3D.new(3.0, 2)
    b = Math.sqrt(3.0**2 + 2**2)
    assert_in_epsilon(a.mag, b, 0.001, 'Failed to return magnitude of vector')
  end

  def test_mag_zero_one3
    a = Vec3D.new(-1, 0)
    assert_equal(a.mag, 1, 'Failed to return magnitude of vector')
  end

  def test_dist3
    a = Vec3D.new(3, 5, 2)
    b = Vec3D.new(6, 7, 1)
    message = 'Failed to return distance between two vectors'
    assert_equal(a.dist(b), Math.sqrt(3.0**2 + 2**2 + 1), message)
  end

  def test_dist_squared3
    a = Vec3D.new(3, 5, 2)
    b = Vec3D.new(6, 7, 1)
    message = 'Failed to return distance squared between two vectors'
    assert_equal(a.dist_squared(b), 3.0**2 + 2**2 + 1, message)
  end

  def test_dot3
    a = Vec3D.new(10, 20, 0)
    b = Vec3D.new(60, 80, 0)
    assert_in_epsilon(a.dot(b), 2200.0, 0.001, 'Failed to dot product')
  end

  def test_self_dot3
    a = Vec3D.new(10, 20, 4)
    assert_in_epsilon(a.dot(a), 516.0, 0.001, 'Failed to self dot product')
  end

  def test_cross3
    a = Vec3D.new(3, 5, 2)
    b = Vec3D.new(6, 7, 1)
    c = Vec3D.new(-9.0, 9.0, -9.0)
    assert_equal(a.cross(b), c, 'Failed cross product')
  end

  def test_set_mag3
    a = Vec3D.new(1, 1)
    assert_equal(a.set_mag(Math.sqrt(32)), Vec3D.new(4, 4), 'Failed to set_mag vector')
  end

  def test_set_mag_block3
    a = Vec3D.new(1, 1)
    assert_equal(a.set_mag(Math.sqrt(32)) { true }, Vec3D.new(4, 4), 'Failed to set_mag_block true vector')
  end

  def test_set_mag_block_false3
    a = Vec3D.new(1, 1)
    assert_equal(a.set_mag(Math.sqrt(32)) { false }, Vec3D.new(1, 1), 'Failed to set_mag_block true vector')
  end

  def test_plus_assign3
    a = Vec3D.new(3, 5)
    b = Vec3D.new(6, 7)
    a += b
    assert_equal(a, Vec3D.new(9, 12), 'Failed to += assign')
  end

  def test_normalize3
    a = Vec3D.new(3, 5)
    b = a.normalize
    assert_in_epsilon(b.mag, 1, 0.001, 'Failed to return a normalized vector')
  end

  def test_normalize3!
    a = Vec3D.new(3, 5)
    a.normalize!
    assert_in_epsilon(a.mag, 1, 0.001, 'Failed to return a normalized! vector')
  end

  def test_inspect3
    a = Vec3D.new(3, 2.000000000000001, 1)
    assert_equal(a.inspect, 'Vec3D(x = 3.0000, y = 2.0000, z = 1.0000)')
  end

  def test_array_reduce3
    array = [Vec3D.new(1, 2), Vec3D.new(10, 2), Vec3D.new(1, 2)]
    sum = array.reduce(Vec3D.new) { |c, d| c + d }
    assert_equal(sum, Vec3D.new(12, 6))
  end

  def test_array_zip3
    one = [Vec3D.new(1, 2), Vec3D.new(10, 2), Vec3D.new(1, 2)]
    two = [Vec3D.new(1, 2), Vec3D.new(10, 2), Vec3D.new(1, 2)]
    zipped = one.zip(two).flatten
    expected = [Vec3D.new(1, 2), Vec3D.new(1, 2), Vec3D.new(10, 2), Vec3D.new(10, 2), Vec3D.new(1, 2), Vec3D.new(1, 2)]
    assert_equal(zipped, expected)
  end

  def test_eql3?
    a = Vec3D.new(3.0, 5.0, 0)
    b = Vec3D.new(3.0, 5.0, 0)
    assert(a.eql?(b))
  end

  def test_not_eql3?
    a = Vec3D.new(3.0, 5.0, 0)
    b = Vec3D.new(3.0, 5.000001, 0)
    refute(a.eql?(b))
  end

  def test_equal3?
    a = Vec3D.new(3.0, 5.0, 0)
    assert(a.equal?(a))
  end

  def test_not_equal3?
    a = Vec3D.new(3.0, 5.0, 0)
    b = Vec3D.new(3.0, 5.0, 0)
    refute(a.equal?(b))
  end

  def test_hash_key3
    x, y, z = 10, 20, 50
    b = Vec3D.new(x, y, z)
    assert_equal(b[:x], x, 'Failed hash key access')
    assert_equal(b[:y], y, 'Failed hash key access')
    assert_equal(b[:z], z, 'Failed hash key access')
  end

  def test_hash_set3
    x = 10
    b = Vec3D.new
    b[:x] = x
    assert_equal(b, Vec3D.new(x, 0, 0), 'Failed to hash assign')
  end
end
