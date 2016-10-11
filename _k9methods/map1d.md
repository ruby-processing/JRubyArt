---
layout: post
title:  "map1d in detail"
---

### Name ###

`map1d` _NB: a different was used than vanilla processing because `map` has another meaning in ruby and we anticipate a possible `map2d` or even `map3d`_.

### Examples ###

Static sketches
{% highlight ruby %}
value = 25
m = map1d(value, (0..100), (0..width))
ellipse(m, height / 2, 10, 10)
{% endhighlight %}

{% highlight ruby %}
value = 110
m = map1d(value, (0..100), (-20..-10))
puts(m)  # Prints '-9.0'
{% endhighlight %}

Regular sketch

{% highlight ruby %}
def settings
  size(200, 200)
end

def setup
  sketch_title 'Using map1d'
  no_stroke
end

def draw
  background(204)
  x1 = map1d(mouse_x, (0..width), (50..150))
  ellipse(x1, 75, 50, 50)
  x2 = map1d(mouse_x, (0..width), (0..200))
  ellipse(x2, 125, 50, 50)
end
{% endhighlight %}

### Description	###

Re-maps a number from one range to another.

In the first example above, the number 25 is converted from a value in the range of 0 to 100 into a value that ranges from the left edge of the window (0) to the right edge (width).

As shown in the second example, numbers outside of the range are not clamped to the minimum and maximum parameters values, because out-of-range values are often intentional and useful.

### Syntax ###

{% highlight ruby %}
map1d(value, (start1..stop1), (start2..stop2))
{% endhighlight %}

### Parameters ###

value	the incoming value to be converted

start1 lower bound of the value's current range

stop1	upper bound of the value's current range

start2	lower bound of the value's target range

stop2 upper bound of the value's target range

Returns	float

### Related ###

`constrained_map` (numbers are clamped to range)

`p5map` (same signature as [processing map][map])

`norm` (same as [processing norm][norm])

`norm_strict` (output is clamped to 0..1.0)

`lerp`

[norm]:https://processing.org/reference/norm_.html
[map]:https://processing.org/reference/map_.html
