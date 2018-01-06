PHI ||= (1 + Math.sqrt(5)) / 2 # golden ratio
GA = PHI * 2 * Math::PI # golden angle

# Useful Vector Utiliies
module VectorUtil
  def self.rotate_vec2d(vectors: [], angle: 0)
    vectors.map { |vector| vector.rotate(angle) }
  end

  def self.vogel_layout(number:, node_size:)
    (0..number).map do |i|
      r = Math.sqrt(i)
      theta = i * ((2 * Math::PI) / (PHI * PHI))
      x = Math.cos(theta) * r * node_size
      y = Math.sin(theta) * r * node_size
      Vec2D.new(x, y)
    end
  end

  def self.fibonacci_sphere(number:, radius:)
    (0..number).map do |i|
      lon = GA * i
      lon /= 2 * Math::PI
      lon -= lon.floor
      lon *= 2 * Math::PI
      lon -= 2 * Math::PI if lon > Math::PI
      lat = Math.asin(-1 + 2 * i / number.to_f)
      x = radius * Math.cos(lat) * Math.cos(lon)
      y = radius * Math.cos(lat) * Math.sin(lon)
      z = radius * Math.sin(lat)
      Vec3D.new(x, y, z)
    end
  end

  def self.spiral_layout(number:, radius:, resolution:, spacing:, inc:)
    n = 0
    angle = nil
    (0..number).map do
      angle = n * resolution
      n += inc
      radius -= angle * spacing
      x = Math.cos(angle) * radius
      y = Math.sin(angle) * radius
      Vec2D.new(x, y)
    end
  end

  def self.cartesian_to_polar(vec:)
    res = Vec3D.new(vec.mag, 0, 0)
    return Vec3D.new unless res.x > 0
    res.y = -Math.atan2(vec.z, vec.x)
    res.z = Math.asin(vec.y / res.x)
    res
  end

  def self.to_cartesian(lat:, long:, radius:)
    latitude = lat
    longitude = long
    x = radius * Math.cos(latitude) * Math.cos(longitude)
    y = radius * Math.cos(latitude) * Math.sin(longitude)
    z = radius * Math.sin(latitude)
    Vec3D.new(x, y, z)
  end

  def self.polar_to_cartesian(vec:)
    return Vec3D.new if vec.mag <= 0
    Vec3D.new(Math.asin(vec.y / vec.mag), vec.mag, -Math.atan2(vec.z, vec.x))
  end
end
