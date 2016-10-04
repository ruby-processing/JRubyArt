---
layout: post
title:  "draw"
---
Called directly after setup, the draw function continuously executes the lines of code contained inside its block until the program is stopped or no_loop is called. The number of times draw executes in each second may be controlled with the frame_rate(xxx).

It is common to call background near the beginning of the [draw loop][draw] to clear the contents of the window. Since pixels drawn to the window are cumulative, omitting background may result in unintended results, especially when drawing anti-aliased shapes or text.

There can only be one [draw][draw] function for each sketch, and [draw][draw] must exist if you want the code to run continuously, or to process events such as [mouse_pressed][mouse_pressed].

{% highlight ruby %}
def draw
  background 0
  # dynamic code
end
{% endhighlight %}

[draw]:https://processing.org/reference/draw_.html
[mouse_pressed]:https://processing.org/reference/mousePressed_.html
