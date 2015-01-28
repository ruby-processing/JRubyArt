## JRubyArt


Is a development fork of [ruby-processing][] that may take an independent existence see [processing-core][] at least in the short term. However until that time:-


First you should install [processing-2.2.1][]

Then create a `~/.jruby_art/config.yml` config file, here is
what mine looks like on arch-linux

```ruby
---
PROCESSING_ROOT: /usr/share/processing

```
The following should work on macosx

```ruby
---
PROCESSING_ROOT: /Applications/Processing.app/Contents/Java
```

To copy processing jars `rake processing_jars`

To compile extensions `jruby -S rake compile` _requires rake-compiler gem_

To build gem `jruby -S rake package`

To install `gem install pkg/jruby_art-0.1.7.gem`

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
