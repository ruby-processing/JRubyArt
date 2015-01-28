## JRubyArt


Is a development fork of [ruby-processing][] that may soon have a somewhat independent existence, see [processing-core][] at least in the short term. Plan was that JRubyArt releases (pre-releases) would use jruby-9.0.0.0 from the start, but now I think it might be more sane to start with jruby-1.7.18. Version 0.2.0.pre since available from rubygems. To build from repo:-


You should (like ruby-processing) install [processing-2.2.1][]

Then create a `~/.jruby_art/config.yml` config file, here is
what mine looks like on arch-linux

```ruby
---
PROCESSING_ROOT: /usr/share/processing

```
However unlike ruby-processing, the core jars become part of the gem and PROCESSING_ROOT is not used at runtime.

The following config should work on macosx

```ruby
---
PROCESSING_ROOT: /Applications/Processing.app/Contents/Java
```

To copy processing jars `rake processing_jars`

To compile extensions `jruby -S rake compile` _requires rake-compiler gem_

To build gem `jruby -S rake package`

To install `gem install pkg/jruby_art-0.2.pre.gem`

To create a new blank sketch

```bash
k9 create my_app 200 200
```

or for 3D opengl sketch

```bash
k9 create my_app 200 200 p3d
```

To run most sketches, all you need is an installed jruby:-

```bash
jruby my_app.rb
```

To run certain sketches, eg those with load_image (or shaders), either use [netbeans][] as your development ide or use the vendored jruby-complete (beyond our control something to do with jruby permissions?).  To install jruby-complete:-

```bash
k9 setup install # requires wget (Now also downloads examples to users home)
```
To run sketches with jruby-complete (rather than installed jruby)

```bash
k9 run my_app.rb # NB: k9 setup install, is a one-time install to gem procedure
```

[Contributing][]

[License][]

[Acknowledgements][]

[Examples][]

[CHANGELOG][]

###Ruby Versions

jruby-9.0.0.0.pre1+ (when sketches run with jruby command)

ruby-2.1.2+ (when sketches are run using k9 command, ie using jruby-complete)

[Acknowledgements]:ACKNOWLEDGEMENTS.md
[CHANGELOG]:CHANGELOG.md
[Contributing]:CONTRIBUTING.md
[Examples]:https://github.com/ruby-processing/JRubyArt-examples
[License]:LICENSE.md
[processing]:https://github.com/processing/processing
[ruby-processing]:https://github.com/jashkenas/ruby-processing
[netbeans]:http://learning-ruby-processing.blogspot.co.uk/2014/10/alternative-ruby-processing-implentation.html
[processing-2.2.1]:https://processing.org/download/
[processing-core]:https://github.com/ruby-processing/processing-core/blob/master/README.md
