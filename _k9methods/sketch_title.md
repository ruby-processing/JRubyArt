---
layout: post
title:  "sketch_title"
---
The `sketch_title` method is probably unique to JRubyArt and propane is a convenient way to set the title of the sketch frame. Normally you only want to set the title once, so sensible it belongs in the setup definition.

{% highlight ruby %}
def setup
  sketch_title 'My sketch'
end
{% endhighlight %}

Should you want a dynamic readout of say `frame_rate`, put it in the draw loop (however there will most likely be some sort of performance penalty) eg:-

{% highlight ruby %}

TITLE_FORMAT = 'frame: %d - fps %0.2f'.freeze
  # ... some code
def draw
  sketch_title(format(TITLE_FORMAT, frame_count, frame_rate)) if frame_count % 10 == 0
  # ... some code
end
{% endhighlight %}
