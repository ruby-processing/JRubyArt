---
layout: post
title:  "Video-Event<sup>2</sup>"
keywords: library, java, video, video_event, processing. reflection

---

<sup>2</sup><i>A built in hybrid ruby/java library</i>

The purpose of the `video_event` library is to allow you to use the vanilla processing reflection methods `captureEvent` and `movieEvent` from the processing `video` library.

A movie example:-

```ruby

# Loop.
#
# Shows how to load and play a QuickTime movie file.
#
#

load_libraries :video, :video_event
include_package 'processing.video'

attr_reader :movie

def setup
  sketch_title 'Loop'
  background(0)
  # Load and play the video in a loop
  @movie = Movie.new(self, data_path('transit.mov'))
  movie.loop
end

def draw
  image(movie, 0, 0, width, height)
end

# use camel case to match java reflect method
def movieEvent(m)
  m.read
end

def settings
  size 640, 360
end
```

A capture example-

```ruby

load_library :video, :video_event

include_package 'processing.video'

attr_reader :cam

def setup
  sketch_title 'Test Capture'
  cameras = Capture.list
  fail 'There are no matching cameras.' if cameras.length.zero?
  start_capture(cameras[0])
end

def start_capture(cam_string)
  # The camera can be initialized directly using an
  # element from the array returned by list:
  @cam = Capture.new(self, cam_string)
  p format('Using camera %s', cam_string)
  cam.start
end

def draw
  image(cam, 0, 0, width, height)
  # The following does the same, and is faster when just drawing the image
  # without any additional resizing, transformations, or tint.
  # set(0, 0, cam)
end

def captureEvent(c)
  c.read
end

def settings
  size 960, 720, P2D
end
```
