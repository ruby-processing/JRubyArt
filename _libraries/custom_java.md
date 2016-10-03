---
layout: post
title:  "Custom Java Library<sup>4</sup>"
keywords: library, ruby, custom

---
<sup>4</sup><i>A custom java library</i>

See [github](https://github.com/ruby-processing/The-Nature-of-Code-for-JRubyArt/tree/master/chp10_nn/xor/ext/nn) for the java source that gets compiled to `nn.jar`, where the `nn.jar` is nested in `library/nn` folder. Here is the sketch that uses the custom nn library:-

```ruby
# The Nature of Code
# Daniel Shiffman
# http://natureofcode.com
# XOR Multi-Layered Neural Network Example
# Neural network code is all in the 'code' folder
load_library :nn

require_relative './landscape'
include_package 'nn'

ITERATIONS_PER_FRAME = 5

attr_reader :inputs, :nn, :count, :land, :theta, :f, :result, :known

def setup
  sketch_title 'XOR'
  @theta = 0.0
  # Create a landscape object
  @land = Landscape.new(20, 300, 300)
  @f = create_font('Courier', 12, true)
  @nn = Network.new(2, 4)
  @count = 0
  # Create a list of 4 training inputs
  @inputs = []
  inputs << [1.0, 0]
  inputs << [0, 1.0]
  inputs << [1.0, 1.0]
  inputs << [0, 0.0]
end

def draw
  lights
  ITERATIONS_PER_FRAME.times do
    inp = inputs.sample
    # Compute XOR
    @known = ((inp[0] > 0.0 && inp[1] > 0.0) || (inp[0] < 1.0 && inp[1] < 1.0)) ? 0 : 1.0
    # Train that sucker!
    @result = nn.train(inp, known)
    @count += 1
  end
  # Ok, visualize the solution space
  background(175)
  push_matrix
  translate(width / 2, height / 2 + 20, -160)
  rotate_x(Math::PI / 3)
  rotate_z(theta)
  # Put a little BOX on screen
  push_matrix
  stroke(50)
  no_fill
  translate(-10, -10, 0)
  box(280)
  land.calculate(nn)
  land.render
  # Draw the landscape
  pop_matrix
  @theta += 0.0025
  pop_matrix
  # Display overal neural net stats
  network_status
end

def network_status
  mse = 0.0
  text_font(f)
  fill(0)
  text('Your friendly neighborhood neural network solving XOR.', 10, 20)
  text(format('Total iterations: %d', count), 10, 40)
  mse += (result - known) * (result - known)
  rmse = Math.sqrt(mse / 4.0)
  out = format('Root mean squared error: %.5f', rmse)
  hint DISABLE_DEPTH_SORT
  text(out, 10, 60)
  hint ENABLE_DEPTH_SORT
end

def settings
  size(400, 400, P3D)
end
```

```ruby
# The Nature of Code
# Daniel Shiffman
# http:#natureofcode.com

# "Landscape" example
class Landscape
  include Processing::Proxy

  attr_reader :scl, :w, :h, :rows, :cols, :z, :zoff

  def initialize(scl, w, h)
    @scl, @w, @h  = scl, w, h
    @cols = w / scl
    @rows = h / scl
    @z = Array.new(cols, Array.new(rows, 0.0))
    @zoff = 0
  end

  # Calculate height values (based off a neural network)
  def calculate(nn)
    val = lambda do |curr, net, x, y|
      curr * 0.95 + 0.05 * (net.feed_forward([x, y]) * 280.0 - 140.0)
    end
    @z = (0...cols).map do |i|
      (0...rows).map do |j|
        val.call(z[i][j], nn, i * 1.0 / cols, j * 1.0 / cols)
      end
    end
  end

  # Render landscape as grid of quads
  def render
    # Every cell is an individual quad
    # (could use quad_strip here, but produces funny results, investigate this)
    (0...z.size - 1).each do |x|
      (0...z[0].size - 1).each do |y|
        # one quad at a time
        # each quad's color is determined by the height value at each vertex
        # (clean this part up)
        no_stroke
        push_matrix
        begin_shape(QUADS)
        translate(x * scl - w * 0.5, y * scl - h * 0.5, 0)
        fill(z[x][y] + 127, 220)
        vertex(0, 0, z[x][y])
        fill(z[x + 1][y] + 127, 220)
        vertex(scl, 0, z[x + 1][y])
        fill(z[x + 1][y + 1] + 127, 220)
        vertex(scl, scl, z[x + 1][y + 1])
        fill(z[x][y + 1] + 127, 220)
        vertex(0, scl, z[x][y + 1])
        end_shape
        pop_matrix
      end
    end
  end
end
```

See also the [pbox2d](https://github.com/ruby-processing/jbox2d) gem.
