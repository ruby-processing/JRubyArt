---
layout: page
title: "Vec3D"
permalink: /classes/vec3d/
---

The Vec3D class is a direct replacement for processings PVector class (when used for 3D work, see Vec2D for 2D version).

### Methods:-
```ruby
a * b # where a is instance of Vec3D and b is a scalar
a + b # where both a and b are both instances of Vec3D
a - b # where both a and b are both instances of Vec3D
a / b # where a is instance of Vec3D and b is a scalar
a == b # where both a and b are both instances of Vec3D
a.angle_between(b) # where both a and b are both instances of Vec3D
a.copy # where a is instance of Vec3D returns a deep copy
a.cross(b) # where both a and b are both instances of Vec3D
a.dist(b) # where both a and b are both instances of Vec3D
a.dist_squared(b) # where both a and b are both instances of Vec3D
a.dot(b) # where both a and b are both instances of Vec3D
a.mag # where a is instance of Vec3D
a.mag_squared # where a is instance of Vec3D
a.normalize # where a is instance of Vec3D
a.normalize! # where a is instance of Vec3D
a.set_mag(b) # where a is instance of Vec3D and b is a scalar
a.set_mag(b) &block # a conditional variant where &block evaluates to a boolean
a.to_a returns array [x, y, z] # where a is an instance of Vec3D
a.to_normal(b) # where b is a instance of Render sends vector a to PApplet.normal
a.to_s # where a is instance of Vec3D
a.to_vertex(b) # where b is a instance of Render sends vector a to PApplet.vertex
a.to_vertex_uv(b, u, v) # where b is a instance of Render sends vector a to PApplet.vertex, with float u and v (texture)
a.x # returns x as a float where a is instance of Vec2D
a.x = b # sets the x value of Vec3D a to the float b
a.y # returns y as a float where a is instance of Vec2D
a.y = b # sets the y value of Vec3D a to the float b
a.z # returns z as a float where a is instance of Vec2D
a.z = b # sets the z value of Vec3D a to the float b
```
### Constructors:-
```ruby
Vec3D.random # returns a new random Vec3D object # with mag 1.0
Vec3D.new # returns new instance where x, y, z are all zero.
Vec3D.new(a, b, c) # where a, b & c are float or numeric (NB: stored as float)
Vec3D.new(vec) # where vec has methods `:x` and `:y` that return float or numeric
               # if vec has no method `:z` then z is set to zero.
```

Note: Normalize on zero vector returns a zero vector for simplicities sake (like PVector)

Example Usages: [Examples][Vec3D]

[Vec3D]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/vec3d/
