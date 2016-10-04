---
layout: post
title:  "mouse_pressed"
---
In vanilla processing [mousePressed][mousePressed] is both a variable and a method, for jruby_art the boolean variable is available as `mouse_pressed?`, whereas you can create events/operations that occur on mouse pressed by adding a [mouse_pressed][mouse_pressed] method as below:-

{% highlight ruby %}
def mouse_pressed  
  # code gets executed on mouse pressed
end
{% endhighlight %}

For sketch with mouse_pressed method see [drawolver][drawolver], follow link for a sketch using [mouse_pressed?][mouse_pressed?].

[mouse_pressed?]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/input/mouse_press.rb
[mousePressed]:https://processing.org/reference/mousePressed_.html
[drawolver]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/contributed/drawolver.rb
