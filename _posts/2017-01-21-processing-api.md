---
layout: post
title:  "The processing api"
date:   2017-01-21 06:24:13
permalink: /processing-api/
---

JRubyArt is the closest thing to a ruby DSL for vanilla processing, it supports `bare` sketches, and `static` sketches, and most of the processing-api see below:-

### The processing-api

Most of the processing methods, as explained in the [Processing Language API][processing], are available as instance methods on your Processing::App. (frame_rate, ellipse, and the 158 others.) This makes it easy as pie to use them within your sketch, but you should prefer snake case to camel case and there are some caveats. Here is an example of a `bare` sketch (you can if you wish create a class wrapped sketch), the main difference with vanilla processing (from the processing ide) is that you need to explicitly create a [settings][settings] method to set the size and sketch mode.

``` ruby
def settings
  size 200, 200
  smooth 8
end

def setup
  sketch_title 'Triangles Gone Wild' # JRubyArt & propane
  color_mode RGB, 1.0
  frame_rate 30
  fill 0.8, 0.6, 0.4
end

def draw
  triangle(rand(width), rand(height), rand(width), rand(height), rand(width), rand(height))
end

```

### Caveats

Here are some the main differences moving from vanilla processing to JRubyArt:-

1. You do not declare types in ruby `vec = PVector.new` instead of `PVector vec = new PVector()` for example, however in this case you should use [Vec2D and Vec3D][vec], which are alternatives to PVector (but with methods that are much more ruby-like, and have extended functionality).

2. There are no void methods (what's evaluated gets returned without needing an explicit return)

3. Everything is an object (this includes primitive types float, integer etc cf. java) [see more][about]
4. Confusing for beginners and especially pythonistas there is often more than one way to do it

5. Processing makes heavy use of java `inner` classes (to make methods and values somewhat globally available) JRubyArt provides the `Processing::Proxy` mixin to somewhat mimic this behaviour see [Ball][ball]. An alternative to consider is to use delegator methods using `extend Forwardable`, requires `require 'forwardable'` see JRubyArt [example][].

6. Use `mouse_pressed?` and `key_pressed?` to access mouse_pressed and key_pressed as variables (ruby can't cope with overloading the `mouse_pressed` and `key_pressed` methods like java) [see example][mouse_pressed?].


In general you should try and code in regular ruby (in JRubyArt), only using processing short-cuts / methods when you need to (ie when ruby alternatives don't exist, many processing short-cuts just aren't needed in ruby). From 3. above you should use:-

* `a**b` for `pow(a, b)`
* `theta.degrees` for `degrees(theta)`
* `theta.radians` for `radians(theta)`
* `x.abs` for `abs(x)`
* `x.ceil` for `ceil(x)`
* `x.round` for `round(x)`
* `str.strip` for `trim(str)`
* `str.hex` for `hex(str)`
* `string.to_i(base=16)` for `unhex(str)`

Other ruby methods to prefer are:-

* `rand(x)` to `random(x)`
* `rand(lo..hi)` to `random(lo, hi)`
* `puts val` (or even just `p val`) to `println(val)`
* `map1d(val, (range1), (range2))` to `map(value, start1, stop1, start2, stop2)`
* `(lo..hi).clip(amt)` to `constrain(amt, lo, hi)` _it is how it is implemented_

To avoid confusion use with ruby `map` use `map1d` for processing `map` function see [example][map1d].

[script]:https://atom.io/packages/script
[about]:https://www.ruby-lang.org/en/about/
[vec]:https://ruby-processing.github.io/JRubyArt/classes.html
[ball]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/contributed/circle_collision.rb
[example]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/external_library/gem/toxiclibs/soft_body/library/blanket/lib/particle.rb
[processing]:https://processing.org/reference/
[map1d]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/contributed/circles.rb
[mouse_pressed?]:https://github.com/ruby-processing/JrubyArt-examples/blob/master/contributed/re_sample.rb
[settings]:https://processing.org/reference/settings_.html
