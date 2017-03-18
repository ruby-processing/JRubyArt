---
layout: post
title:  "data_path"
date:   2016-05-23 05:04:00
categories: jruby_art update
permalink: /data_path/
---
The purpose of the `data_path` wrapper is to provide the absolute data path to a sketches `data` folder. In vanilla processing the direct use of this method is discouraged, owing to the way it has been implemented (it is used internally and may be the cause file access issues in JRubyArt). The `data_path` method is implemented in JRubyArt, and does not rely on the vanilla-processing version.

It should be used to get around the need to provide an absolute data path on macosx to run sketches that contain `load_image`, `load_shader` etc that otherwise could not find the data. However it should also be used on Windows and Linux to avoid the need to use jruby-complete when running such sketches.

### Simple usage ###
```ruby
def setup
  sketch_title 'Load Image'
  # The file "jelly.jpg" must be in the data folder
  # of the current sketch to load successfully
  @a = load_image(data_path('jelly.jpg'))    
  no_loop # Makes draw only run once
end

def draw
  image @a, 0, 0
  image @a, @a.width, 0, @a.width / 2, @a.height / 2
end

def settings
  size 300, 200
end
```

Or when saving frames, here frames are saved to the `data/output` folder

```ruby
attr_reader :recording

def setup
  sketch_title 'Save Frames'
  @recording = false
end

def draw
  background(0)
  # An arbitrary oscillating rotating animation
  # so that we have something to render
  (0...TAU).step(0.2) do |a|
    push_matrix
    translate(width / 2, height / 2)
    rotate(a + sin(frame_count * 0.004 * a))
    stroke(255)
    line(-100, 0, 100, 0)
    pop_matrix
  end
  # The '#' symbols makes Processing number the files automatically
  save_frame(data_path('output/frames####.png')) if recording
  # Let's draw some stuff to tell us what is happening
  # NB: Content created after this line does not show up rendered files
  text_align(CENTER)
  fill(255)
  if !recording
    text('Press r to start recording.', width / 2, height - 24)
  else
    text('Press r to stop recording.', width / 2, height - 24)
  end
  # A red dot for when we are recording
  stroke(255)
  recording ? fill(255, 0, 0) : no_fill
  ellipse(width / 2, height - 48, 16, 16)
end

def key_pressed
  # If we press r, start or stop recording!
  case key
  when 'r', 'R'
    @recording = !recording
  end
end

def settings
  size(640, 360)
end
```

### More sophisticated usage ###
You can use your ruby knowledge to 'dry up' vanilla processing sketches and to remove the need to type `data_path` many times in a sketch. Please note that we cannot rely on JRuby to convert an array of ruby-string to an array of java-string, this is why we need `glsl_files.to_java(:string)`. However the array of images does not require such an explicit conversion, _JRuby generally just does the right thing_.

```ruby
# Earth model with bump mapping, specular texture and dynamic cloud layer.
# Adapted from the THREE.js tutorial to processing by Andres Colubri,
# translated to JRubyArt by Martin Prout:
# https://learningthreejs.com/blog/2013/09/16/how-to-make-the-earth-in-webgl/

attr_reader :earth, :clouds, :earth_shader, :cloud_shader, :earth_rotation
attr_reader :clouds_rotation, :target_angle

SHADERS = %w(EarthFrag.glsl EarthVert.glsl CloudFrag.glsl CloudVert.glsl).freeze
SHADER_NAME = %i(earth_frag earth_vert cloud_frag cloud_vert).freeze
IMAGES = %w(earthmap1k earthcloudmap earthcloudmaptrans earthbump1k earthspec1k).freeze
IMAGE_NAME = %i(earth_tex cloud_tex alpha_tex bump_map spec_map).freeze

def setup
  sketch_title 'Blue Marble'
  @earth_rotation = 0
  @clouds_rotation = 0
  glsl_files = SHADERS.map { |shade| data_path(shade) }
  shaders = SHADER_NAME.zip(glsl_files.to_java(:string)).to_h
  images = IMAGES.map { |img| load_image(data_path("#{img}.jpg")) }
  textures = IMAGE_NAME.zip(images).to_h
  @earth_shader = load_shader(shaders[:earth_frag], shaders[:earth_vert])
  earth_shader.set('texMap', textures[:earth_tex])
  earth_shader.set('bumpMap', textures[:bump_map])
  earth_shader.set('specularMap', textures[:spec_map])
  earth_shader.set('bumpScale', 0.05)
  @cloud_shader = load_shader(shaders[:cloud_frag], shaders[:cloud_vert])
  cloud_shader.set('texMap', textures[:cloud_tex])
  cloud_shader.set('alphaMap', textures[:alpha_tex])
  @earth = create_shape(SPHERE, 200)
  earth.setStroke(false)
  earth.setSpecular(color(125))
  earth.setShininess(10)
  @clouds = create_shape(SPHERE, 201)
  clouds.setStroke(false)
end

def draw
  background(0)
  translate(width / 2, height / 2)
  point_light(255, 255, 255, 300, 0, 500)
  target_angle = map1d(mouse_x, (0..width), (0..TWO_PI))
  @earth_rotation += 0.05 * (target_angle - earth_rotation)
  shader(earth_shader)
  push_matrix
  rotate_y(earth_rotation)
  shape(earth)
  pop_matrix
  shader(cloud_shader)
  push_matrix
  rotate_y(earth_rotation + clouds_rotation)
  shape(clouds)
  pop_matrix
  @clouds_rotation += 0.001
end

def settings
  size(600, 600, P3D)
end

```
