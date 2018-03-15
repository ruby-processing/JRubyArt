---
layout: post
title:  "Replacing create_graphics with buffer convenience method"
---
In vanilla processing there is a [createGraphics][processing] method that allows you to create a graphics into an off-screen buffer, that should only really be called outside the draw loop (_to avoid memory issues_). The `buffer` method reduces the boilerplate code required by wrapping the user provided block with `begin_draw` and `end_draw`, in practice you probably won't use this method much but it illustrates how can use ruby blocks in your code.

### The buffer method ###
Here is the `buffer` method extracted from the `HelperMethods` module see `helper_methods.rb`

```ruby
# Nice block method to draw to a buffer.
# You can optionally pass it a width, a height, and a renderer.
# Takes care of starting and ending the draw for you.
def buffer(buf_width = width, buf_height = height, renderer = @render_mode)
  create_graphics(buf_width, buf_height, renderer).tap do |buffer|
    buffer.begin_draw
    yield buffer
    buffer.end_draw
  end
end

```

```java
PGraphics pg;

void setup() {
  size(200, 200);
  pg = createGraphics(100, 100);
}

void draw() {
  pg.beginDraw();
  pg.background(102);
  pg.stroke(255);
  pg.line(pg.width*0.5, pg.height*0.5, mouseX, mouseY);
  pg.endDraw();
  image(pg, 50, 50);
}

```
In JRubyArt we have created a buffer convenience method that wraps `beginDraw` and `endDraw` all you need to do is provide a `block` so the above code becomes:-

```ruby

attr_reader :pg

def settings
  size(200, 200)
end

def setup
  sketch_title 'Using buffer method'
  size(200, 200)
  @pg = buffer(100, 100) do |buff|
    buff.background(102)
    buff.stroke(255)
    buff.line(buff.width*0.5, buff.height*0.5, mouse_x, mouse_y)
  end
end

def draw
  image(pg, 50, 50)
end

```

[processing]:https://processing.org/reference/createGraphics_.html
