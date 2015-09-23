java_alias :background_int, :background, [Java::int]

def setup
  sketch_title 'On Top'
  on_top
  frame_rate(10)
end

def draw
  background_int 0
  if frame_count == 3
    puts 'ok'
    exit
  end
end

def settings
  size(300, 300)
end

