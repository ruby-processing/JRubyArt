## JRubyArt


Is a development fork of [ruby-processing][]

First you should install processing-2.2.1

Then create a `~/.k9rc` config file, here is
what mine looks like on Arch-linux

```ruby
---
PROCESSING_ROOT: /usr/share/processing

```
On the mac

```ruby
---
PROCESSING_ROOT: /Applications/Processing.app/Contents/Java
```

To copy processing jars `rake processing_jars`

To compile extensions `jruby -S rake compile` _requires rake-compiler gem_

To build gem `jruby -S rake package`

To install `gem install pkg/jruby_art-0.1.2.gem`

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

To run certain sketches, eg those with load_image (or shaders), either use [netbeans][] as your development ide or provide your own jruby-complete (beyond our control something to do with jruby permissions?).

```bash
java -jar jruby-complete my_app.rb
```

Future versions will probably include jruby-complete, but then running sketches will require a bespoke command like the original ruby-processing.

[Contributing][]

[License][]

[Acknowledgements][]

[Examples][]


[Acknowledgements]:ACKNOWLEDGEMENTS.md
[Contributing]:CONTRIBUTING.md
[Examples]:examples
[License]:LICENSE.md
[processing]:https://github.com/processing/processing
[ruby-processing]:https://github.com/jashkenas/ruby-processing
[netbeans]:http://learning-ruby-processing.blogspot.co.uk/2014/10/alternative-ruby-processing-implentation.html
