load_library :ruby_library

def settings
  size 200, 200
end

def setup
  sketch_title 'Local Ruby'
  RubyLibrary.new
end

def draw
  exit
end
