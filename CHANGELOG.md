## JRubyArt CHANGELOG

It might seem a little of that this log starts at version 0.1.2, the reason for this is that previous version relate to earlier versions which were essentially a clone of ruby-processing.

### Version 0.2.4

Can't wait forever for jruby-9000, this release is require to promote the new toxiclibs gem.

### Version 0.2.3

Now using curl instead of wget "following the path of least resistance for enfeebled Mac users" and also there might be better Windows support for curl vs wget. Now includes a library loader for jars (supports video and sound library etc), added control_panel and boids library.

### Version 0.2.2
This was meant to be the pre-jruby-9000 version, but is now the pre library_loader
version

### Version 0.2.1

Features jruby-complete-1.7.19 and filtered native jars (attempt at load according to OS and Arch) works linux64

### Version 0.2.0

First pre release version features jruby-complete-1.7.18

### Version 0.1.7

Now installs jruby-complete-1.7.17 (which is a good deal smaller), also includes experimental Proxy extension to access draw, pre and post loops by reflection

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
