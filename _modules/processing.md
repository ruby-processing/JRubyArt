---
layout: post
title:  "Processing"
keywords: Processing, module
---
The `App` class (`Processing::App`) is a subclass of `PApplet`, and one way or another your JRubyArt sketch inherits from `Processing::App`, it is just not obvious in a `nude` or `bare` JRubyArt sketch.  Unless you explicitly create your own Sketch class, the default is to create an instance of `Sketch < Processing::App` as below. What a bare sketch would look like when wrapped prior to eval.

```ruby
class Sketch < Processing::App
  # your bare sketch code may include 'draw' should include 'settings'
end

Sketch.new
```

What a nude static sketch would look like when wrapped prior to eval.

```ruby
class Sketch < Processing::App
  def setup
    sketch_title 'Nude Sketch'
    # your nude sketch code here eg `background 0`
    no_loop
  end
  def settings
    size(150, 150)
  end
end

Sketch.new
```
You should be aware that all vanilla processing sketches are similary wrapped prior to java compilation.  The idea of processing and also JRubyArt is to make it easy to create sketches, so this is all you need to know, and you should probably look at [propane][propane] if you really prefer class wrapped sketches.

For JRubyArt see also `Processing` module for more details, you could also see magic (_but it 'really' is not necessary_)

[propane]:https://ruby-processing.github.io/propane/
