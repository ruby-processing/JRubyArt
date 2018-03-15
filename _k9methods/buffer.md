---
layout: post
title:  "Replacing create_graphics with buffer convenience method"
---
In vanilla processing there is a [createGraphics][processing] method that allows you to create a graphics into an off-screen buffer, that should only really be called outside the draw loop (_to avoid memory issues_). The `buffer` method reduces the boilerplate code required by wrapping the user provided block with `begin_draw` and `end_draw`, in practice you probably won't use this method much, however it does illustrates how can use ruby blocks in your code.

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

### A simple example ###

```ruby
attr_reader :pg

def setup
  sketch_title 'Create graphics using :buffer'
  @pg = buffer(60, 70, P2D) do |buf|
    buf.background 51
    buf.no_fill
    buf.stroke 255
    buf.rect 0, 0, 59, 69
  end
end

def draw
  fill 0, 12
  rect 0, 0, width, height
  image pg, mouse_x - 60, mouse_y - 70
end

def settings
  size 640, 380, P2D
end

```

For real example usage see [luciernagas][firefly], [trefoil][trefoil] sketches

[firefly]:JRubyArt-examples/examples/grid_method/luciernagas.rb
[trefoil]:JRubyArt-examples/processing_app/demos/graphics/trefoil.rb


[processing]:https://processing.org/reference/createGraphics_.html
