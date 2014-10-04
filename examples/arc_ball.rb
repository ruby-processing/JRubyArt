
require 'jruby_art'

class MySketch < Processing::AppGL
  def setup
    size 200, 200, P3D
    Processing::ArcBall.init(self)
    fill 200, 0, 0
    stroke 0
  end

  def draw
    lights
    background 0
    box 100, 100, 100
  end
end

MySketch.new(title: 'My Sketch')
