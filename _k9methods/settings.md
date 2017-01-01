---
layout: post
title:  "settings"
---
Apart from nude sketches, all sketches require a user defined [settings][settings] method. This is where you define the sketch size (can be fullscreen) and render mode. Regular processing sketches hide this in a pre-process step that converts `pde` code to valid java code (on linux you can find the java code in the `/tmp` folder, and in some other temporary location on OSX and Windows).

Minimal code default renderer:-
```ruby
def settings
  size 200, 200
end
```

Minimal code fullscreen default renderer:-
```ruby
def settings
  fullscreen
end
```

Minimal code fullscreen opengl 3D renderer:-
```ruby
def settings
  size 200, 200, P3D
end
```

Minimal code fullscreen opengl 3D renderer:-
```ruby
def settings
  fullscreen P3D
end
```

For hi-dpi screens:-

```ruby
def settings
  size 200, 200
  pixel_density(2)
end
```

You should also put `smooth` inside [settings][settings]

NB: as with vanilla-processing you can access the `width` and `height` variables within the sketch, eg in draw loop or mouse_pressed.
[settings]:https://processing.org/reference/settings_.html
