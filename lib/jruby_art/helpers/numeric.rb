# encoding: utf-8
# frozen_string_literal: false

class Numeric #:nodoc:
  def degrees
    self * 180 / Math::PI
  end

  def radians
    self * Math::PI / 180
  end
end
