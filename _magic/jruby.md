---
layout: post
title:  "JRuby"
keywords: ruby, java, jruby
---
### java interfaces ###
JRuby classes can mix in Java interfaces as modules in order to implement them.
```ruby
class SomeFlexibleClass
  include java.lang.Runnable
  include java.lang.Comparable
end
```

JRuby does a wonderful thing with Ruby’s blocks, where a block can be converted to the appropriate Java interface. It works by converting the block to a Proc, and then decorating it with a proxy object that runs the block for any method called on the interface. Runnable is the prime example here. You should try this yourself, also see using callbacks [hype][hype] library examples for more sophisticated stuff.

```ruby
button = javax.swing.JButton.new "Press me!"
button.add_action_listener { |event| event.source.text = "I done been pressed." }
```
Read more about [java interface][wip] etc. Otherwise see [wiki][wiki]

### java reflection ###

In vanilla processing, you can [create libraries][library] in java that can access the sketch `pre`, `draw`, `post`, `mouseEvent` and `keyEvent` methods by java reflection, but you must `register` these methods with the `PApplet`. We can also register custom methods (but sadly only those without parameters which is why we found another way of dealing with `selectInput` see [chooser][chooser], `movieEvent` see [video_event][video_event]).

Here we show you how to `registerMethods` in a ruby class by java reflection in JRuby (requires the `!become_java` method).

```ruby
# A simple demonstration of vanilla processing # 'reflection' methods
# in JRubyArt see register_send.rb for the guts...

require_relative 'register_send'

def settings
  size 300, 200
end

def setup
  sketch_title 'Reflection Voodoo'
  RegisterSend.new self
  no_loop
end

def draw
  fill(0, 0, 200)
  ellipse(170, 115, 70, 100)
end
```

Here is the class that does the reflection (it needs to become java so that self gets recognized as a java object)

```ruby
require 'jruby/core_ext' # required to allow become_java!

# This class demonstrates how to use 'reflection' methods in ruby-processing
# NB: the class must become a java object to get registered. This is an
# advanced feature in vanilla processing, mainly used by libraries.
class RegisterSend
  attr_reader :parent

  def initialize(parent)
    @parent = parent
    parent.java_send :registerMethod, [java.lang.String, java.lang.Object], :draw, self
    parent.java_send :registerMethod, [java.lang.String, java.lang.Object], :pre, self
  end

  def pre
    puts 'before draw'
    parent.background(100)
  end

  def draw
    puts 'at begin draw...'
    parent.fill(200, 100)
    parent.ellipse(150, 100, 200, 60)
  end
  # putting become_java! here works OK
  become_java!
end
```

![reflection voodoo]({{ site.github.url }}/assets/reflection_voodoo.png)

__Note__ how the transparent ellipse is placed on top of the solid ellipse, so the reflection element must get drawn after the original sketch element.

[library]:https://github.com/processing/processing/wiki/Library-Basics
[wip]:http://kares.org/jruby-ji-doc/
[wiki]:https://github.com/jruby/jruby/wiki/CallingJavaFromJRuby
[hype]:{{ site.github.url }}/libraries/hype
[chooser]:{{ site.github.url }}/libraries/chooser
[video_event]:{{ site.github.url }}/libraries/video_event
