
# JRubyArt
![travis status](https://travis-ci.org/ruby-processing/JRubyArt.svg)

## Requirements
A clean start for `jruby_art` that works best with the latest version of [processing-3.1](https://github.com/processing/processing/releases) and [jruby-9.1.0.0](http://jruby.org/download) see [wiki](https://github.com/ruby-processing/JRubyArt/wiki/Building-latest-gem) for building gem from this repo.  Changes from processing- 2.0 to [processing-3.0 here](https://github.com/processing/processing/wiki/Changes-in-3.0). Should work on same platforms as vanilla processing (windows, mac, linux) for Android see Yuki Morohoshi [rubuto-processing3][].
## Requirements
 
A suitable version of ruby (MRI ruby > 2.2 or `jruby-9.1.0.0+`) to download gem. 

`processing-3.1`

`jdk1.8.0_92+` can be openjdk with OpenJFX _a separate download works on ArchLinux_, currently FX2D is experimental is expected to replace JAVA2D in the near future see changes above...

### recommended installs (JRubyArt is currently hard-coded to expect them)

processing `video` and `sound-1.3.2+` libraries _best installed from the processing-3.1 ide_


## Configuration

Config file is `config.yml` in the `~/.jruby_art folder` so can co-exist with a ruby-processing install

```yaml
# YAML configuration file for jruby_art
# K9_HOME: "/home/ruby2.3.0 ... /jruby_art" #windows users may need to set this
PROCESSING_ROOT: /home/tux/processing-3.1
# important sketch_book path may be different for processing-3.0
sketchbook_path: /home/tux/sketchbook 
```

## Install Steps (assumes you have requirements above) 

```bash
 gem install jruby_art
 k9 setup install # installs jruby-complete-9.1.0.0
 k9 setup unpack_samples # downloads and installs samples to ~/k9_samples
 cd ~/k9_samples/contributed
 k9 --nojruby run jwishy.rb # unless you have jruby-9.1.0.0 installed or config JRUBY: 'false'
 k9 run jwishy.rb # if you have jruby-9.1.0.0 installed or config JRUBY: 'false'
```
## Create sketches from built in templates
```bash
k9 create fred 200 200                # basic sketch fred.rb
k9 create fred 200 200 p2d            # basic P2D sketch fred.rb
k9 create fred 200 200 --wrap         # class wrapped sketch fred.rb
k9 create fred 200 200 p2d --wrap     # class wrapped P2D sketch fred.rb
k9 create ted 200 200 --emacs         # class wrapped sketch ted.rb for emacs / netbeans
k9 create ted 200 200 p2d --emacs     # class wrapped P2D sketch ted.rb for emacs / netbeans
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

# NB: changes for processing-3.0
# size, full_screen, pixel_density and smooth should all be moved to settings (this is hidden 
# to users of processing ide, but not for JRubyArt, or for Eclipse NetBeans users). The FX2D 
# rendering mode was introduced, and was expected to replace JAVA2D (as default rendering mode) 
# but may not now happen, and not for processing-3.0 in any case.
def settings
  size 400, 300
end
```
## Run Sketch
`k9 run sketch.rb`
or
`k9 --nojruby run sketch.rb`

be prepared to KILL the odd java process (that doesn't exit cleanly all the time), watch seems now to work

## Watch sketches
```bash
k9 watch sketch.rb # don't try and change render mode, or use FX2D render mode during watch yet
```
## Open pry console on sketch
```bash
k9 live sketch.rb # pry is bound to $app # needs `jruby -S gem install pry`
```
## Example sketches

[Worked Examples](https://github.com/ruby-processing/samples4ruby-processing3) more to follow, feel free to add your own, especially ruby-2.1+ syntax now we can. These can now be downloaded using `k9 setup unpack_samples` please move existing k9_samples.

## Conversion Tool

I wrote this little script to convert sketches from ruby-processing (processing-2) to jruby_art (processing-3.0) [here](https://gist.github.com/monkstone/1a658bdda4ea21c204c5).

See The-Nature-of-Code-Examples-in-Ruby converted to [The-Nature-of-Code-Examples-for-JRubyArt](https://github.com/ruby-processing/The-Nature-of-Code-for-JRubyArt) using the script.

[rubuto-processing3]:https://github.com/hoshi-sano/ruboto-processing3
