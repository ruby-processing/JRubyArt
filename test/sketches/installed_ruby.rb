load_library :dummy # Dummy is for testing installed ruby library loading

def settings
  size 200, 200
end

def setup
  sketch_title 'Installed Ruby'
  Dummy.new
end

def draw
  exit
end
