---
layout: post
title:  "optional and conditional blocks"
keywords: blocks, optional
---

For `Vec2D` and `Vec3D` there is a method `set_mag` which can accept an optional `block`, and if given it should evaluate to a `boolean`.  The magnitude is only set when the `block` evaluates to true (without a block the magnitude is set unconditionally providing new value is a scalar).  

See below for a `Vec2D` example where velocity is an instance of `Vec2D`:-

```ruby
velocity.set_mag(MAXSPEED) { velocity.mag > MAXSPEED }
```

In this way we can limit the velocity of a particle say, to a maximum speed.
