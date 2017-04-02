---
layout: post
title:  "Color Explained"
---
See [processing color][processing] reference for details, but color is stored as `signed java int` (and bit shifting is used to parse Red, Green and Blue components) but generally you do not need to worry about that, as we either use processing convenience methods, or where necessary our modified color method does transforms for you eg conversion of web string to color

### processing ###
The `*.pde` files get pre-processed to `java` before compiling, allowing you to write this:-

```java
color c2 = #FFCC00; // this gets pre-processed to `int c2 = 0xffFFCC00`
```
This is yet another vanilla `processing` convention that you must learn to get around once you leave the processing ide.

### JRubyArt / propane ###

in ruby we instead support use of quoted web-string (string is at least a valid type in ruby and java)

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

### Making Necessity into a Virtue ###

Many vanilla processing libraries (eg Hype, Wordcram and ColorHarmony) make use of the vanilla processing conventions to define `web` colors. But we have gone one better in JRubyArt and propane to use ruby to quickly create arrays of `web` color and even `dictionaries` of `web` colors. Now such lists would be useless unless we could convert the `web` colors to valid `color` int for use in processing as we have with the [web_to_color_array][web] method.

```ruby
WEB = %w(#CC6600 #CC9900 #FFFFFF).freeze
web_to_color_array(WEB)
# output = [-3381760, -3368704, -1]
```

For creation and use of a hash / dictionary of web colors see this [Wordcram sketch][wordcram]. If you need to convert an array of `color` int (say from ColorHarmony) to ruby string, then use `p52ruby` method that returns a web string of the form '%w(#CC6600 #CC9900 #FFFFFF)' from `[-3381760, -3368704, -1]`. Or if you are more sophisticated and using the `toxiclibs` gem to explore color theory, we have created a method `to_ruby_string` for the `ColorList` class see [palette genertor example][palette]

[palette]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/external_library/gem/toxiclibs/color_utils/palette_generator.rb
[wordcram]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/external_library/gem/ruby_wordcram/fruits.rb
[web]:{{site.github.url}}/summary/
[processing]:https://processing.org/reference/color_datatype.html
