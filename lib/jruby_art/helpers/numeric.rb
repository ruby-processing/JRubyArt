# extends Numeric class to provide degrees and radians convenience methods
class Numeric  
  def degrees
    self * 180 / Math::PI
  end

  def radians
    self * Math::PI / 180
  end
end
