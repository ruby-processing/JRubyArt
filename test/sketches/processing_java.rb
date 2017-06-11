load_library :pdf

def settings
  size 200, 200
end

def setup
  sketch_title 'Processing Java'
  puts library_loaded?(:pdf) ? 'ok' : 'oops?'
end

def draw
  exit
end
