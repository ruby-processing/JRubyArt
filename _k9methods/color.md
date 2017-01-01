---
layout: post
title:  "color explained"
---
See [processing color][processing] reference for details, but color is stored as `signed java int` (and bit shifting is used to parse Red, Green and Blue components) but generally you do not need to worry about that, as we either use processing convenience methods, or where necessary our modified color method does transforms for you eg conversion of web string to color

### processing ###

```java
color c2 = #FFCC00; // this gets pre-processed to `int c2 = 0xffFFCC00`
```

### JRubyArt / propane ###

in ruby we instead support use of quoted web-string

```ruby
c2 = color('#FFCC00') # we return a signed java int, note quoted string
```

For JRubyArt we enable a convenience method color (based on processing PGraphics color), and for the most part this method behaves as the processing color method (but it is implemented differently under the hood to work with ruby Numeric/Fixnum). Basically the input can be an Array of Fixnum (approximating to a processing int) an Array of Float (approximating to processing float) or a special hexadecimal string or a hexadecimal number. See / try example sketch.

```ruby

# Creating Colors (Homage to Albers).
#
# Creating variables for colors that may be referred to
# in the program by their name, rather than a number.
attr_reader :redder, :yellower, :orangish

def setup
  sketch_title 'Homage to Albers'
  @redder = color 204, 102, 0
  @yellower = color 204, 153, 0
  @orangish = color 153, 51, 0
  # These statements are equivalent to the statements above.
  # Programmers may use the format they prefer.

  # hex color as a String (NB quotes are required)

  # @redder = color '#CC6600'
  # @yellower = color '#CC9900'
  # @orangish = color '#993300'

  # or alternatively as a hexadecimal

  # @redder = color 0xFFCC6600
  # @yellower = color 0xFFCC9900
  # @orangish = color 0xFF993300
end

def draw
  no_stroke
  background 51, 0, 0
  push_matrix
  translate 80, 80
  fill orangish
  rect 0, 0, 200, 200
  fill yellower
  rect 40, 60, 120, 120
  fill redder
  rect 60, 90, 80, 80
  pop_matrix
  push_matrix
  translate 360, 80
  fill redder
  rect 0, 0, 200, 200
  fill orangish
  rect 40, 60, 120, 120
  fill yellower
  rect 60, 90, 80, 80
  pop_matrix
end

def settings
  size 640, 360, FX2D
end

```

[processing]:https://processing.org/reference/color_datatype.html
