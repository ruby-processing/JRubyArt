require 'jruby_art'

class GreyBoxes < Processing::App
  def setup
    size(600, 800)
    frame_rate(2)
    background(200)
  end

  def draw
    stroke_setup
    diameter = rand(100)
    rect(rand(width), rand(height), diameter, diameter)
  end

  def stroke_setup
    [:stroke, :stroke_weight, :fill].each do |method|
      send(method, rand(255))
    end
  end

  def mouse_pressed
    background 200
  end 
end

GreyBoxes.new title: 'Oh so many boxes'
