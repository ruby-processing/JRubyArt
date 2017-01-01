---
layout: page
title:  "ArcBall"
permalink: /classes/arcball/
---

ArcBall is a user input interface to make a 3D object rotate in an intuitive way. It uses quaternions to represent orientations, although this implementation detail is hidden in JRubyArt. Use the ArcBall to enable mouse drag rotation and mouse wheel zoom in 3D sketches. Hold down x, y or z keys to constrain the rotation axis.

See a simple example below, where the box (a cube in this case) gets centered in the middle of the display. 

```ruby
def setup
  sketch_title 'Arcball Box'
  ArcBall.init self
  fill 180
end

def draw
  background 50 
  box 300, 300, 300
end

def settings
  size 600, 600, P3D
  smooth 8
end
```

Alternative Examples: [3D Menger][menger], [Retained Shape][shape], [Constrained ArcBall][constrain]

[menger]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/vec3d/retained_menger.rb
[shape]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/arcball/arcball_shape.rb
[constrain]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/arcball/constrain.rb
