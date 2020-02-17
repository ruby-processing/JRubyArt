# frozen_string_literal: true

java_alias :background_int, :background, [Java::int]

def setup
  sketchPath(SKETCH_ROOT)
  frame_rate(10)
  puts sketchPath
end

def draw
  background_int 0
  exit if frame_count == 5
end

def settings
  size(300, 300)
end
