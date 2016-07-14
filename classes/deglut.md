---
layout: page
title:  "Deglut"
permalink: /classes/deglut/
---

Deglut is a fast math module that does sin and cos for integer degrees

Methods:-
{% highlight ruby %}
# Returns sine from integer degree input (uses look up table)
Deglut.sin(deg)
# Returns cosine from integer degree input (uses look up table)
Deglut.cos(deg)
{% endhighlight %}

Example Usages: [Analog Clock][clock], [Function Grapher][grapher]

[clock]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/fastmath/clock.rb
[grapher]: https://github.com/ruby-processing/JRubyArt-examples/blob/master/contributed/grapher.rb
