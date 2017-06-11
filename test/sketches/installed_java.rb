load_library :hype

def settings
  size 200, 200
end

def setup
  sketch_title 'Installed Java'
  puts library_loaded?(:hype) ? 'ok' : 'oops?'
end

def draw
  exit
end
