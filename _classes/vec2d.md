---
layout: page
title: "Vec2D"
permalink: /classes/vec2d/
---

The Vec2D class is a direct replacement for processings PVector class (when used for 2D work, see Vec3D for 3D version).

### Methods:-
```ruby
a * b # where a is instance of Vec2D and b is a scalar
a + b # where both a and b are both instances of Vec2D
a - b # where both a and b are both instances of Vec2D
a / b # where a is instance of Vec2D and b is a scalar
a == b # where both a and b are both instances of Vec2D
a.angle_between(b) # where both a and b are both instances of Vec2D
a.copy # where a is instance of Vec2D returns a deep copy
a.cross(b) # where both a and b are both instances of Vec2D returns float
a.dist(b) # where both a and b are both instances of Vec2D
a.dot(b) # where both a and b are both instances of Vec2D
a.heading # where a is instance of Vec2D
a.lerp(b) # where both a and b are both instances of Vec2D
a.lerp!(b) # where both a and b are both instances of Vec2D
a.mag # where a is instance of Vec2D
a.normalize # where a is instance of Vec2D
a.normalize! # where a is instance of Vec2D
a.normalize!(b) # where both a and b are both instances of Vec2D
a.rotate(b) # where both a is an instance of Vec2D and b is scalar radians
a.rotate!(b) # where both a is an instance of Vec2D and b is scalar radians
a.set_mag(b) # where both a is instance of Vec2D and b is scalar
a.set_mag(b) &block # a conditional variant where &block evaluates to a boolean
a.to_a # returns an array [x, y] where a is instance of Vec2D
a.to_s # returns a string where a is instance of Vec2D
a.to_vertex(b) # where b is a instance of Render sends vector a to PApplet.vertex
a.x returns x as a float # where a is instance of Vec2D
a.x=b # sets the x value of Vec2D a to the float b
a.y # returns y as a float # where a is instance of Vec2D
a.y=b # sets the y value of Vec2D a to the float b
```

### Constructors:-

```ruby
Vec2D.from_angle(a) # returns a new Vec2D object # where a is a float radians
Vec2D.random # returns a new random Vec2D object # with mag 1.0
Vec2D.new # returns new instance where x, y are both zero.
Vec2D.new(a, b) # where a and b are both float or numeric (NB: stored as float)
Vec2D.new(vec) # where vec has methods `:x` and `:y` that return float or numeric
```

### Chaining:-

Vec2D operations can normally be chained, which give us huge benefits over PVector, and thanks to syntatic sugar combinations of such operations read like math equations eg you want a Vec2D object `c` that is the midpoint between two points `a` and `b` (represented by vectors) we have:-

```ruby
c = (a + b) / 2
```

Or we can even use ruby `inject` to `sum` an array of Vec2D (useful in say `flocking`)

```ruby
average = array.inject(Vec2D.new, &:+) # elegantly
average = array.reduce(Vec2D.new) { |c, d| c + d } # expressively
```

Example Usages: [Examples][Vec2D]

Note: Vec2D cross product [returns float][float] cf PVector which always returns a vector _because it is really a 3D vector_.
Also normalize on zero vector returns a zero vector for simplicities sake (like PVector)

[Vec2D]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/vec2d/
[float]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/vec2d/library/circle/lib/points.rb
