---
layout: post
title:  "Processing::Proxy"
keywords: processing, module, namespace
---
The sole purpose of the `Processing::Proxy` module is to provide access to the `Processing::App` variables and methods similar to the access to [Inner classes][inner] afforded by vanilla processing. To do this your class should `include Processing::Proxy` as below:-

```ruby
class MyClass
  include Processing::Proxy
  # access to sketch methods and variables is similar to java Inner class
end
```

Now we know this is not `kosher` and as you get more comfortable with JRubyArt you may eschew this egregious hack, but initially at least you will find it highly convenient. There are plenty of examples included with the samples (because it so damn convenient). See [frame_of_reference][sketch] sketch and [Plane][Plane] and [Cylinder][Cylinder] classes


[sketch]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/vec3d/frame_of_reference.rb
[Plane]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/vec3d/library/geometry/lib/plane.rb
[Cylinder]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/vecmath/vec3d/library/geometry/lib/cylinder.rb

The hair shirted brigade might want to take a look at `forwardable` and make their classes `extend Forwardable` instead. See the [revolute_joint][joint] pbox2d example, where the [Windmill][Windmill] and [ParticleSystem][ParticleSystem] both `extend Forwardable`.

[joint]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/external_library/gem/pbox2d/revolute_joint/revolute_joint.rb
[Windmill]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/external_library/gem/pbox2d/revolute_joint/windmill.rb
[ParticleSystem]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/external_library/gem/pbox2d/revolute_joint/particle_system.rb
[inner]: {{ site.github.url }}/magic/java
