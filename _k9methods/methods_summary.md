---
layout: post
title:  "summary"
---

The MathTool and HelperMethods modules implement some of the processing convenience methods

### color method
A convenience method that returns a 'color' int for processing
```ruby
color(*args)           # where args can be a hex string, a hexadecimal number, etc. see examples
color('#CC6600')       # hexadecimal string, can be lower-case
color(0xFFCC6600)      # hexadecimal
color(255)             # white
color(0)               # black
color(255, 0, 0)       # red
color(0, 0, 255)       # blue
color(0, 0, 255, 100)  # blue with alpha value 100
```
Example Usages: [Creating][color], [Blend Color][blend_color]

### hsb_color method
A convenience method that returns a 'color' int for processing for `hsb` input, where hue, saturation and brightness are in range `0..1.0`
```ruby
hsb_color(hue, sat, bright) # where args are ruby float
```

### web_to_color_array method
A convenience method that converts an array of web color strings to an array of 'color' int. Particularly useful when working with the Joshua Davis Processing-HYPE library.
```ruby
WEB = %w(#CC6600 #CC9900 #FFFFFF).freeze
web_to_color_array(WEB)
# output = [-3381760, -3368704, -1]
```

### map1d method
A replacement for processings map function, maps val (range1) to range2 using a linear transform.
```ruby
map1d(val, range1, range2) # where val is an input float range1 is source and range2 is target
# simple example
map1d(10, (0..20), (0..1.0)) # returns 0.5
```

Example Usages: [Mandelbrot][mandelbrot], [Game of Life][conway]

### radians and degrees methods
A replacement for processings radians(x) and degree(x) methods _in ruby everything is an object!!_

```ruby
x.radians # we did this by monkey patching ruby numeric
x.degrees
```

Note: ruby already provides x.abs, x.to_s, and x.to_f replacing abs(x), str(x), and float(x) etc

Example Usages:
[bezier ellipse][bezier], [brick tower][brick_tower]

### Processing max and min convenience methods

We make these methods available in JRubyArt, by mocking them using ruby `Enumerable` `max` and `min` methods, you should prefer to use the `Enumerable` methods directly since they are more flexible (you can even provide a [comparator block][enumerable] to change basis of ordering). 

### find_method method
A convenient way of finding a method
```ruby
find_method(method) # where method is a method name or fragment
# simple example
puts find_method('map') # see output below
```
```bash
constrained_map
map1d
p5map
```

[bezier]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/form/bezier_ellipse.rb
[brick_tower]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/form/brick_tower.rb
[mandelbrot]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/contributed/mandelbrot.rb
[conway]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/topics/shaders/conway.rb
[color]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/color/creating.rb
[blend_color]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/color/blend_color.rb
[enumerable]:http://apidock.com/ruby/Enumerable/max
