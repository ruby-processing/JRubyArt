---
layout: post
title:  "grid"
---

### Name ###

`grid` _A nice method to run a given block for a grid. Lifted from action_coding/Nodebox._

### Ruby signature ###

If it were pure ruby code it would look like this

```ruby
# @param width size of 1st dimension
# @param height size of 2nd dimension
# @param width_step step of 1st dimension (defaults to 1)
# @param height_step step of 2nd dimension (defaults to 1)
def grid(width, height, width_step = 1, height_map = 1)
  # implmentation in java wraps yield with single loop that mocks 2D loop
  yield(x, y)
end
```

### A simple grid

```ruby
grid(4, 4) { |x, y| puts format('x: %d, y: %d', x, y) }
```
output:-

```bash
x: 0, y: 0
x: 0, y: 1
x: 0, y: 2
x: 0, y: 3
x: 1, y: 0
x: 1, y: 1
x: 1, y: 2
x: 1, y: 3
x: 2, y: 0
x: 2, y: 1
x: 2, y: 2
x: 2, y: 3
x: 3, y: 0
x: 3, y: 1
x: 3, y: 2
x: 3, y: 3
```

### A real example

```ruby
# Creative Coding
# # # # #
# Vera Molnar – 25 Squares
# # # # #
# Interpretation by Martin Vögeli
# Converted to JRubyArt Martin Prout
# # # # #
# Based on code by Indae Hwang and Jon McCormack
def settings
  size(600, 600)
end

def setup
  sketch_title '25 Squares'
  rect_mode(CORNER)
  no_stroke
  frame_rate(1) # set the frame rate to 1 draw call per second
end

def draw
  background(180) # clear the screen to grey
  grid_size = 5 # rand(3..12)   # select a rand number of squares each frame
  gap = 5 # rand(5..50) # select a rand gap between each square
  # calculate the size of each square for the given number of squares and gap between them
  cellsize = (width - (grid_size + 1) * gap) / grid_size
  position = -> (count) { gap * (count + 1) + cellsize * count + rand(-5..5) }
  grid(grid_size, grid_size) do |x, y|
    rand(0..5) > 4 ? fill(color('#a11220'), 180.0) : fill(color('#884444'), 180.0)
    rect(position.call(x), position.call(y), cellsize, cellsize)
  end
  # save your drawings when you press keyboard 's' continually
  save_frame('######.jpg') if key_pressed? && key == 's'
end # end of draw
```

### A more complicated example


```ruby
# Description:
# This is a full-screen demo
# Using JRubyArt grid method
GRID_SIZE = 100
HALF = 50
def setup
  sketch_title 'Full Screen'
  no_stroke
end

def draw
  lights
  background 0
  fill 120, 160, 220
  grid(width, height, GRID_SIZE, GRID_SIZE) do |x, y|
    push_matrix
    translate x + HALF, y + GRID_SIZE
    rotate_y(((mouse_x.to_f + x) / width) * Math::PI)
    rotate_x(((mouse_y.to_f + y) / height) * Math::PI)
    box 90
    pop_matrix
  end
end

def settings
  full_screen(P3D)
end
```

For more examples see [grid method examples](https://github.com/ruby-processing/JRubyArt-examples/tree/master/examples/grid_method)
