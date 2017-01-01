---
layout: page
title:  "File Chooser"
permalink:   /classes/chooser/
---

A native file chooser for JRubyArt, bases around vanilla processing `selectInput`.

### Usage ###

First load the `chooser` library, this creates the interface:-

`public void file_selected(java.io.File selected);` 

which you need to define in your sketch, to make use the `selected` file. This sketch makes use of the JRubyArt method `resizable` (vanilla processing `surface.setResizable(true)`) so that we can change sketch size to match our `image`. Note we need to guard against `img` being `nil` or sketch will crash. You may change the the prompt `select an image` in `select_input` but you cannot change `file_selected` which is hard-wired to cope with java reflection. 

### example sketch ###
```ruby
load_library :chooser

attr_reader :img

def settings
  size(400, 200)
end

def setup
  sketch_title 'Chooser'
  resizable
  fill 0, 0, 200
  text('Click Window to Load Image', 10, 100)
end

def draw
  image(img, 0, 0) unless img.nil?
end

def file_selected(selection)
  if selection.nil?
    puts 'Nothing Chosen'
  else
    @img = load_image(selection.get_absolute_path)
    surface.set_size(img.width, img.height)
  end
end

def mouse_clicked
  @img = nil
  # java_signature 'void selectInput(String, String)'
  select_input('select an image', 'file_selected')
end
```

See more [examples here][examples]

[examples]:https://github.com/ruby-processing/JRubyArt-examples/tree/master/processing_app/library/file_chooser
