java_alias :background_int, :background, [Java::int]

def setup
  sketch_title('P2D sketch')
  frame_rate(10)
end

def draw
  background_int 255
  if frame_count == 3
    puts 'ok'
    exit
  end
end

def settings
  size(300, 300, P2D)
end

