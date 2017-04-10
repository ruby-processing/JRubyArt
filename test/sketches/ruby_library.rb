load_library :boids

def setup
  boids = Boids.flock(n: 20, x: 0, y: 0, w: width, h: height)
  puts boids.class
  exit
end

def settings
  size(300, 300)
end
