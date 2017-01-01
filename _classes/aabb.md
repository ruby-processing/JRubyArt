---
layout: page
title:  "AaBb"
permalink:   /classes/aabb/
---

AaBb is a 2D axis aligned bounding box for JRubyArt

Constructors:-
```ruby
# Regular constructor where vec_one and vec_two are instances of Vec2D
AaBb.new(center: vec_one, extent: vec_two)
# Alternative constructor where vec_one and vec_two are instances of Vec2D
AaBb.new(min: vec_one, max: vec_two)
```

Methods:-
```ruby
center # returns the AaBb center Vec2D
extent # returns the AaBb extent as Vec2D
position(vec)           # set the center as vec
position(vec) { block } # set the center as vec, if block evaluates to true
contains?(vec)          # returns true/false if box contains point at vec
```

Example: [Constrained Box][example]

[example]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/vec2d/aabb_test.rb
