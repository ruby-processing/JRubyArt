# frozen_string_literal: true
# Re-open Numeric so that we can do simple degree and radian conversions
# conversion factors are 180 / Math::PI and Math::PI / 180

class Numeric #:nodoc:
  def degrees
    self * 57.29577951308232
  end

  def radians
    self * 0.017453292519943295
  end
end
