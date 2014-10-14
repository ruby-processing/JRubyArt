require 'jruby_art'
require 'lib/koch_fractal'

class Koch < Processing::App

  def setup
    size(800, 250)
    background(255)
    frame_rate(1)  # Animate slowly
    @k = KochFractal.new(self)
    smooth 8
  end

  def draw
    background(255)
    # Draws the snowflake!
    @k.render
    # Iterate
    @k.next_level
    # Let's not do it more than 5 times. . .
    @k.restart if @k.count > 5
  end
end

Koch.new(title: 'Koch Fractal')
