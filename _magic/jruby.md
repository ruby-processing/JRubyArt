---
layout: post
title:  "JRuby"
keywords: ruby, java, jruby
---
JRuby classes can mix in Java interfaces as modules in order to implement them.
```ruby
class SomeFlexibleClass
  include java.lang.Runnable
  include java.lang.Comparable
end
```

JRuby does a wonderful thing with Ruby’s blocks, where a block can be converted to the appropriate Java interface. It works by converting the block to a Proc, and then decorating it with a proxy object that runs the block for any method called on the interface. Runnable is the prime example here. You should try this, also see using callbacks [hype][hype] library examples for more sophisticated stuff.

```ruby
button = javax.swing.JButton.new "Press me!"
button.add_action_listener { |event| event.source.text = "I done been pressed." }
```
Read more about [java interface][wip] etc. Otherwise see [wiki][wiki]

[wip]:http://kares.org/jruby-ji-doc/
[wiki]:https://github.com/jruby/jruby/wiki/CallingJavaFromJRuby
[hype]:{{ site.github.url }}/libraries/hype
