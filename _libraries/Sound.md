---
layout: post
title:  "Sound<sup>5</sup>"
keywords: library, java, sound, processing. reflection

---

<sup>5</sup><i>A vanilla processing (java) library</i>

First load the sound library (assumes it was installed using the processing3 ide)

You might just as well `include_package` to get namespace access to the `processing.sound` package.

```ruby
load_library :sound
include_package 'processing.sound'

attr_reader :sound_file

def setup
  sketch_title 'Sample'
  no_stroke
  # Load a soundfile
  @sound_file = SoundFile.new(self, data_path('vibraphon.aiff'))
  report_settings
  # Play the file in a loop
  sound_file.loop
end

def draw
  background 40, 1
  red = map1d(mouse_x, (0..width), (30..255))
  green = map1d(mouse_y, (height..0), (30..255))
  fill(red, green, 0)
  ellipse(mouse_x, mouse_y, 30, 30)
  manipulate_sound
end

def manipulate_sound
  # Map mouse_x from 0.25 to 4.0 for playback rate. 1 equals original playback
  # speed 2 is an octave up 0.5 is an octave down.
  sound_file.rate(map1d(mouse_x, (0..width), (0.25..4.0)))
  # Map mouse_y from 0.2 to 1.0 for amplitude
  sound_file.amp(map1d(mouse_y, (0..width), (0.2..1.0)))
  # Map mouse_y from -1.0 to 1.0 for left to right
  sound_file.pan(map1d(mouse_y, (0..height), (-1.0..1.0)))
end

def report_settings
  # These methods return useful infos about the file
  p format('SFSampleRate= %d Hz', sound_file.sample_rate)
  p format('SFSamples= %d samples', sound_file.frames)
  p format('SFDuration= %d seconds', sound_file.duration)
end

def settings
  size 640, 360, P2D
end
```
