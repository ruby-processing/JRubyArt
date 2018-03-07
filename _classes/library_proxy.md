---
layout: post
title:  "LibraryProxy"
keywords: processing, abstract class, library
---
The purpose of the `LibraryProxy` class is to provide access to [processing reflection][library] methods:-

### Vanilla processing Library Methods

Java processing provides the following __Library Methods__

1. pre()

   A Method that's called just after beginDraw(), meaning that it can affect drawing.
2. draw()

   Method that's called at the end of draw(), but before endDraw().
3. post()

   Method called after draw has completed and the frame is done. No drawing allowed.
4. mouseEvent(MouseEvent e)

   Called when a mouse event occurs in the parent applet. Drawing is allowed because mouse events are queued, unless the sketch has called noLoop().
5. keyEvent(KeyEvent e)

   Called when a key event occurs in the parent applet. Drawing is allowed because key events are queued, unless the sketch has called noLoop().

### JRubyArt implementation


Since jruby_art-1.4.0 we can readily access all the above library methods in library classes and include them in our sketches (and TouchEvent could be added if required). For simplicities sake you should use the jruby_art `library_loader` to load the `proxy_library` into the sketch. We can then create ruby classes that inherit from `LibraryProxy` to give us access to the above methods. Note `LibraryProxy` is an abstract java class, because it's `draw` method is abstract. We need to implement that method in our ruby class, but an empty `draw` method will work just fine, if you don't want to use a draw loop.   

```ruby
class MyLibrary < LibraryProxy
  # access to pre, draw, etc
  def draw
  end
end
```

Example sketch using my_library
```ruby
# A simple demonstration of vanilla processing 'reflection' methods using
# JRubyArt :library_proxy. See my_library.rb code for the guts.
load_library :library_proxy
require_relative 'my_library'

def settings
  size 300, 200
end

def setup
  sketch_title 'Reflection Voodoo'
  MyLibrary.new self
  no_loop
end

def draw
  fill(0, 0, 200)
  ellipse(170, 115, 70, 100)
end
```
__my_library.rb__

```ruby
# This class demonstrates how by inheriting from the abstract class LibraryProxy
# we can access 'pre', 'draw' and 'post' (Note we need the 'draw' method even
# though it can be empty)
class MyLibrary < LibraryProxy
  attr_reader :app

  def initialize(parent)
    @app = parent
  end

  def pre
    background(100) # artificial usage
  end

  def draw
    app.fill(200, 100)
    app.ellipse(150, 100, 200, 60)
  end
end
```

For more example usage see [deadgrid_events.rb and its library][dead_grid] or [key_event.rb][key_event] and [my_library.rb][my_library] for simpler usage.

[dead_grid]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/library_proxy/deadgrid_events.rb

[key_event]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/library_proxy/key_event.rb

[my_library]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/library_proxy/library/my_library/my_library.rb

![reflection voodoo]({{ site.github.url }}/assets/reflection_voodoo.png)

[library]:https://github.com/processing/processing/wiki/Library-Basics
