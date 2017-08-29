load_library :test_sound

def settings
  size 200, 200
end

def setup
  sketch_title 'Local Java'
  puts library_loaded?(:test_sound) ? 'ok' : 'oops?'
end

def draw
  exit
end
