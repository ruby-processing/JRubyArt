
# JRubyArt
[![Gem Version](https://badge.fury.io/rb/jruby_art.svg)](http://badge.fury.io/rb/jruby_art)
![Travis CI](https://travis-ci.org/ruby-processing/JRubyArt.svg)
Versions before JRubyArt-1.5.1, are unsupported, please update, preferably to latest version, especially if you are on windows

_Note the main reason for the current build to fail on travis is when the current version of [processing is not available from maven central][testing], it has only ever been available by third parties (I am eternally hopeful that one day processing.org will see the light), actually rvm with jruby as used by travis-ci is also pretty crap as judged by the build traces._

## Requirements
A clean start for `jruby_art` that works best with the latest version of [processing-3.4](https://github.com/processing/processing/releases) and [jruby-9.2.0.0](http://jruby.org/download) see [wiki](https://github.com/ruby-processing/JRubyArt/wiki/Building-latest-gem) for building gem from this repo.  Changes from processing-2.0 to [processing-3.0 here](https://github.com/processing/processing/wiki/Changes-in-3.0). Should work on same platforms as vanilla processing (windows, mac, linux, [raspberrypi][pi]) for Android see Yuki Morohoshi [rubuto-processing3][].
## Requirements

A suitable version of ruby (MRI `ruby 2.3+` or `jruby-9.2.0.0`) to download gem.

`processing-3.4`

`jdk1.8.0_171+` can be openjdk with OpenJFX _a separate download works on ArchLinux_, currently FX2D is still experimental but might in the future replace JAVA2D as default renderer, however for hardware graphics acceleration there is alway P2D / P3D.

### recommended installs (JRubyArt is currently hard-coded to expect them)

processing `video` and `sound-1.3.2+` libraries _best installed from the processing-3.4+ ide_ although for `video` on linux at least it may better to install the development version with support for gstreamer-1.0 (gstreamer-0.1.x is either deprecated or completely missing). NB: a replacement processing sound library is also under active development. 

## Configuration

You can if you wish leave configuration to the `new` autoconfig tool (delete existing config to do this). The config file is `config.yml` in the `~/.jruby_art folder`, the autoconfig gets run on `k9 --install` expected to just work on `macOS`, output may need tuning on `windows` / `linux` check with `k9 --check` (run both after gem install for both)

```yaml
# YAML configuration file for jruby_art
# K9_HOME: "/home/ruby2.4.0 ... /jruby_art" # windows users may need to set this
PROCESSING_ROOT: "/home/tux/processing-3.4" # typical linux shown
# important sketch_book path may be different for processing-3.0
sketchbook_path: "/home/tux/sketchbook"
template: bare
sketch_title: 'Edit Static Sketch' # for static sketch only
width: 600 # for static sketch only
height: 600 # for static sketch only
```

## Install Steps (assumes you have requirements above)

```bash
 gem install jruby_art
 k9 --install # installs jruby-complete-9.2.0.0 and downloads and installs samples to ~/k9_samples
 cd ~/k9_samples/contributed
 k9 --run jwishy.rb # if you have jruby-9.2.0.0 installed or config `JRUBY: false`
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
See above
be prepared to `KILL` the odd java process (ie when sketch does not exit cleanly)

## Watch sketches
```bash
k9 --watch sketch.rb # NB: doesn't work with FX2D render mode
```
## Open pry console on sketch
```bash
k9 --live sketch.rb # pry is bound to Processing.app # needs `jruby -S gem install pry`
```
## Example sketches

[Worked Examples](https://github.com/ruby-processing/JRubyArt-examples) and, [The-Nature-of-Code-Examples-for-JRubyArt](https://github.com/ruby-processing/The-Nature-of-Code-for-JRubyArt) feel free to add your own, especially ruby-2.2+ syntax now we can. These can now be downloaded using `k9 --install` please move existing `k9_samples` if you wish to keep them.  The current releases features changes to `control_panel` reducing boilerplate sketches required to use library.

[rubuto-processing3]:https://github.com/hoshi-sano/ruboto-processing3
[testing]:http://ruby-processing.github.io/testing/testing/
[pi]:http://ruby-processing.github.io/JRubyArt/raspberrypi_started/
