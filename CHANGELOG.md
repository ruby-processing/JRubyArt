## JRubyArt CHANGELOG

It might seem a little of that this log starts at version 0.1.2, the reason for this is that previous version relate to earlier versions which were essentially a clone of ruby-processing.

### Version 0.1.3

Move config file from ~/.k9rc to ~/.jruby_art/config.yml, created installer for jruby-complete.jar.  For sketches needing to be run with jruby-complete use `rp5 run sketch.rb` (includes shader sketches with `load_image`.


### Version 0.1.2

First point release, requires user build, supports 2D and opengl sketches, but no library support. Sketches will only run with jruby (jruby-complete is not included). To run sketches with load_image jruby-complete is required, so either provide that or use netbeans as your ide (with jruby plugin).
