# frozen_string_literal: true

def setup
  sketch_title 'On Top'
  on_top
  frame_rate(10)
end

def draw
  background 0
  return unless frame_count == 5

  puts 'ok'
  exit
end

def settings
  size(300, 300)
end
