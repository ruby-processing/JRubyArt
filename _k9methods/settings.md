---
layout: post
title:  "settings"
---
Apart from nude sketches, all sketches require a user defined settings method. This is where you define the sketch size (can be fullscreen) and render mode. Regular processing sketches hide this in a pre-process step that converts `pde` code to valid java code (on linux you can find the java code in the `/tmp` folder, and in some other temporary location on OSX and Windows).

Minimal code default renderer:-
{% highlight ruby %}
def settings
  size 200, 200
end
{% endhighlight %}

Minimal code fullscreen default renderer:-
{% highlight ruby %}
def settings
  fullscreen
end
{% endhighlight %}

Minimal code fullscreen opengl 3D renderer:-
{% highlight ruby %}
def settings
  size 200, 200, P3D
end
{% endhighlight %}

Minimal code fullscreen opengl 3D renderer:-
{% highlight ruby %}
def settings
  fullscreen P3D
end
{% endhighlight %}

For hi-dpi screens:-

{% highlight ruby %}
def settings
  size 200, 200
  pixel_density(2)
end
{% endhighlight %}

Yous should also put `smooth` inside settings
