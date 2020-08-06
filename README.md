# JRubyArt

[![Gem Version](https://badge.fury.io/rb/jruby_art.svg)](https://badge.fury.io/rb/jruby_art) ![Travis CI](https://travis-ci.org/ruby-processing/JRubyArt.svg)

A new version for jdk11 use, does not require an installed `vanilla processing`, however if installed you can use processing-ide to download libraries. Configuration file is incompatible with that of previous version of JRubyArt (and you should move or rename old `config.yml` to keep it). This version will run with a default configuration file but you won't be able to use processing libraries, until you match configuration to your setup. Illegal reflective access warning should be fixed for this release (by using JOGL-2.4.0-rc jars), though you may need to define `JAVA_HOME` for JRuby warnings to be suppressed.

## Requirements

A clean start for `jruby_art` with custom processing core included, built for [jruby-9.2.13.0](http://jruby.org/download) see [wiki](https://github.com/ruby-processing/JRubyArt/wiki/Building-latest-gem) for building gem from this repo.

## Requirements

A suitable version of ruby (MRI `ruby 2.4+` or `jruby-9.2.13.0`) to download gem. NB: avoid ruby 2.7, it is guaranteed to give you problems (you've been warned)
Tested and working AdoptOpenJDK 11-13, OpenJ9 14, if you have any issues with opengl sketches with distro installed JDK use a JDK from AdoptOpenJDK.


## Configuration

You can if you wish leave configuration to the `new` autoconfig tool (delete or rename existing config to do this). The config file is `config.yml` in the `~/.jruby_art folder`, the autoconfig gets run on `k9 --install` expected to just work.

**config.yml on linux**

```yaml
---
processing_ide: true
library_path: "/home/tux/sketchbook"
MAX_WATCH: 32
JRUBY: true
template: bare
java_args:
  # Global java_args can be used to suppress reflective access warn
```

## Install Steps (assumes you have requirements above)

```bash
 gem install jruby_art
 k9 --install # installs jruby-complete-9.2.13.0 and downloads and installs samples to ~/k9_samples
 cd ~/k9_samples/contributed
 k9 --run jwishy.rb # if you have jruby-9.2.13.0 installed or config `JRUBY: false`
 # to use jruby-complete set `JRUBY: false` in config
```

## Create sketches from built in templates

```bash
k9 --create fred 200 200                # basic sketch fred.rb
k9 --create fred 200 200 p2d            # basic P2D sketch fred.rb
```

To create either a `class` wrapped sketch or `emacs` sketch set `template: class` or `template: emacs` in config.yml

## Simple Sketch

```ruby

def setup
  sketch_title 'My Sketch'
end

def draw
  background 0
  fill 200
  ellipse width / 2, height / 2, 300, 200
end

def settings
  size 400, 300
end
```

## Run Sketch

See above be prepared to `KILL` the odd java process (ie when sketch does not exit cleanly)

## Watch sketches

```bash
k9 --watch sketch.rb # NB: doesn't work with FX2D render mode
```

## Open pry console on sketch

```bash
k9 --live sketch.rb # pry is bound to Processing.app # needs `jruby -S gem install pry`
```

## Example sketches

[Worked Examples](https://github.com/ruby-processing/JRubyArt-examples) and, [The-Nature-of-Code-Examples-for-JRubyArt](https://github.com/ruby-processing/The-Nature-of-Code-for-JRubyArt) feel free to add your own, especially ruby-2.4+ syntax now we can. These can now be downloaded using `k9 --install` please move existing `k9_samples` if you wish to keep them.

[adopt]: https://adoptopenjdk.net/
[pi]: http://ruby-processing.github.io/JRubyArt/raspberrypi_started/
[rubuto-processing3]: https://github.com/hoshi-sano/ruboto-processing3
[testing]: http://ruby-processing.github.io/testing/testing/
[warnings]: https://monkstone.github.io/jruby_art/update/2019/09/10/Reflective_Access.html
