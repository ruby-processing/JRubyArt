# frozen_string_literal: true

java_alias :background_float_float_float, :background, [Java::float, Java::float, Java::float]

def setup
  frame_rate(10)
end

def draw
  background_float_float_float 39, 232, 51
  return unless frame_count == 5

  puts 'ok'
  exit
end

def settings
  size(300, 300, P3D)
end
