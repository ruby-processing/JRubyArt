---
layout: post
title:  "setup"
---
Apart from nude sketches, all sketches will probably have a user defined [setup][setup] method. This is where you define the sketch title and where static code belongs.

```ruby
def setup
  sketch_title 'My sketch'
  # ... static code
end
```

 Note to make variables declared in setup in the rest of sketch, you should make use of ruby `attr_reader` as for the `pts` array below.

```ruby
attr_reader :pts

 def setup
   sketch_title 'My sketch'
   @pts = []
   # ... static code
 end
 ```  

 When the you can access `pts` in say the draw loop

 ```ruby
 def draw
   p pts.length
   # ... static code
 end
 ```  

[settings]:https://processing.org/reference/setup_.html
