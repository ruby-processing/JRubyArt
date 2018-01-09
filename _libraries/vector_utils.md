---
layout: post
title:  "vector_utils<sup>2</sup>"
keywords: processing, vector, library
---
We have created a `vector_utils` library that implements a number of vector methods see sample usage:-

### Vec2D examples

```ruby
load_library :vector_utils

attr_reader :points

def settings
  size 600, 600
  smooth 4
end

def setup
  sketch_title 'Vogel Layout'
  @points = VectorUtil.vogel_layout(number: 200, node_size: 10.0)
end

def draw
  background 0
  fill 200, 130, 100
  translate width / 2, height / 2
  points.each do |vec|
    ellipse vec.x, vec.y, 10, 10
  end
end
```

```ruby
load_library :vector_utils

attr_reader :points

def settings
  size 600, 600
  smooth 4
end

def setup
  sketch_title 'Spiral Layout'
  @points = VectorUtil.spiral_layout(
    number: 300,
    radius: 200,
    resolution: 0.3,
    spacing: 0.01,
    inc: 1.15
  )
end

def draw
  background 0
  fill 200, 130, 100
  translate width / 2, height / 2
  points.each do |vec|
    ellipse vec.x, vec.y, 10, 10
  end
end
```

### Vec3D example

```ruby
load_library :vector_utils

attr_reader :points

def settings
  size 600, 600, P3D
  smooth 4
end

def setup
  sketch_title 'Fibonacci Layout'
  ArcBall.init self
  @points = VectorUtil.fibonacci_sphere(number: 500, radius: 300.0)
end

def draw
  background 0
  fill 200, 130, 100
  lights
  directional_light 200, 200, 200, -1, 1, 0
  points.each do |vec|
    push_matrix
    translate vec.x, vec.y, vec.z
    polar = VectorUtil.cartesian_to_polar(vec: vec)
    box 10
    rotate_y vec.y
    rotate_z vec.z
    pop_matrix
  end
end
```
