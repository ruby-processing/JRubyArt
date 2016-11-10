# frozen_string_literal: true
# Axis aligned bounding box class (AABB would clash with Toxicgem)
class AaBb
  attr_reader :center, :extent

  def initialize(center:, extent:)
    @center = center
    @extent = extent
  end

  def self.from_min_max(min:, max:)
    new(center: (min + max) * 0.5, extent: max - min)
  end

  def position(vec)
    return @center = vec unless block_given?
    @center = vec if yield
  end

  def scale(d)
    @extent *= d
  end

  def contains?(vec)
    rad = extent * 0.5
    return false unless (center.x - rad.x..center.x + rad.x).cover? vec.x
    (center.y - rad.y..center.y + rad.y).cover? vec.y
  end
end
