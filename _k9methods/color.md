---
layout: post
title:  "color method in detail"
---

For JRubyArt we enable a convenience method color (based on processing PGraphics color), and for the most part this method behaves as the processing color method (but it is implemented differently under the hood to work with ruby Numeric/Fixnum). Basically the input can be an Array of Fixnum (approximating to a processing int) an Array of Float (approximating to processing float) or a special hexadecimal string or a hexadecimal number. See [example sketch here](https://https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/color/creating.rb).
