## JRubyArt CHANGELOG

It might seem a little of that this log starts at version 0.1.2, the reason for this is that previous version relate to earlier versions which were essentially a clone of ruby-processing.

### Version 0.1.6

Vec2D and Vec3D get `:to_curve_vertex`, see included example. Also new in examples is how to use jar libraries (toxiclibs) with JRubyArt.

### Version 0.1.5

Now you can wrap a bare sketch with `k9 wrap sketch.rb` sensibly wraps bare P2D, P3D and default processing mode sketches.  The runner now laso makes a similar check.

### Version 0.1.4

Now with k9 you can run `bare` sketches, like original ruby-processing but with less sugar. So instead of `cos` use `Math,cos` etc, further no attempt has been made to mimic processing inner-class behaviour (bad OO practice). 


### Version 0.1.3

Move config file from ~/.k9rc to ~/.jruby_art/config.yml, created installer for jruby-complete.jar.  For sketches needing to be run with jruby-complete use `k9 run sketch.rb` (this includes shader sketches with `load_image`) or use netbeans with jruby-plugin to develop your sketches. For 3D sketches (or to use P2D) inherit from AppGL, both AppGL and App inherit directly from PApplet. Examples have been moved to there own repo `k9 setup install` downloads and install jruby-complete and downloads and extracts sample to users HOME directory.


### Version 0.1.2

First point release, requires user build, supports 2D and opengl sketches, but no library support. Sketches will only run with jruby (jruby-complete is not included). To run sketches with load_image jruby-complete is required, so either provide that or use netbeans as your ide (with jruby plugin).
