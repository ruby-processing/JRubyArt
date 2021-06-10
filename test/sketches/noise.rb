# frozen_string_literal: true

def setup
  sketch_title('Noise sketch')
  color_mode(HSB, 1.0)
  frame_rate(10)
end

def draw
  background(noise(1, 1, 3, 0.2), 1.0, 1.0)
  return unless frame_count == 5

  puts 'ok'
  exit
end

def settings
  size(300, 300)
end
