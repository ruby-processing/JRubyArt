# jruby_art-3.0
A clean start for `jruby_art` based on processing-3.0 alpha and jruby-9.0.0.0 rc1, having difficulty with original JRubyArt and jruby-9000, also this might be the way to go retaining the ruby-processing good bits, with no legacy overhang.
## Requirements
 
 Clone this repository

`jruby-9.0.0.0.rc1+`

`processing-3.0a10+`

`processing video library (processing-3.0a5+)`

`jdk1.8.0_45+`

## Configuration

Config file is `config.yml` in `~/.jruby_art folder` so can co-exist with regular install

```yaml
# YAML configuration file for jruby_art
# RP5_HOME: "/home/ruby2.2.0 ... /jruby_art" #windows users may need to set this
PROCESSING_ROOT: "/home/tux/processing-3.0a10"
```

## Steps 

Manually copy video.jar to lib folder (core.jar should get copied there on build)
```bash
 rake # should build the gem and run minitest
 gem install --local jruby_art-0.3.0.gem
 rp5 setup install # Downloads and install jruby-complete-9.0.0.0.rc1
```
## Create sketches from built in templates
```bash
rp5 create fred 200, 200               # basic FX2D sketch fred.rb
rp5 create fred 200, 200, p2d          # basic P2D sketch fred.rb
rp5 create fred 200, 200 --wrap        # class wrapped FX2D sketch fred.rb
rp5 create fred 200, 200, p2d --wrap   # class wrapped P2D sketch fred.rb
```

## Simple Sketch
```ruby
# :sketch_title belongs in setup it is a convenience method of jruby_art-3.0
def setup
  sketch_title 'My Sketch'
end

def draw
  background 0
  fill 200
  ellipse width / 2, height / 2, 300, 200
end

# size goes here since processing-3.0a10, the processing guys hide this
# by doing pre-processing on the pde file (check the java output).
# FX2D works better for me (on linux) than JAVA2D with Ben Fry current loop() kludge
def settings
  size 400, 300, FX2D
end
```
## Run Sketch
`rp5 run sketch.rb`
or
`rp5 --nojruby run sketch.rb`

be prepared to KILL the odd java process (that doesn't exit cleanly all the time), watch seems now to work (but no easy way of disposing last window) failing

## Watch sketches
```bash
rp5 watch sketch.rb # don't try and change render mode, or use the FX2D render mode
```

## Example sketches

[Worked Examples](https://github.com/jruby_art/samples4jruby_art3) more to follow, feel free to add your own, especially ruby-2.1+ syntax now we can. These can now be downloaded using `rp5 setup unpack_samples` please move existing rp_samples.

## Conversion Tool

I wrote this little script to convert sketches from jruby_art (2.0) to jruby_art-3.0 [here](https://gist.github.com/monkstone/1a658bdda4ea21c204c5)

