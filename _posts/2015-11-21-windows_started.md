---
layout: post
title:  "Getting Started On Windows"
date:   2015-11-21 14:15:13
categories: jruby_art update
permalink: /windows_start/
---
### Getting Started With JRubyArt (stolen from [Ben Lewis][ben])

If you love to code because it is a creative process, then you should give JRubyArt a try because it can be used to create music, art, animations, videos and much more. Also since it is based on the latest [Processing][processing] you can access a vast range of libraries to make the difficult things easier.

### What Is Processing?

Processing is a simple language, based on Java, that you can use to create digital graphics. It's easy to learn, fun to use, and has an amazing online community comprised of programmers, visual artists, musicians, and interdisciplinary artists of all kinds.

Processing was built by Benjamin Fry and [Casey Reas][casey] ☯, two protegés of interdisciplinary digital art guru John Maeda at the MIT Media Lab.

Since the project began in 2001, it's been helping teach people to program in a visual art context using a simplified version of Java. It comes packaged as an IDE that can be downloaded and used to create and save digital art “sketches”.

In 2009, Jeremy Ashkenas (aka jashkenas, creator of Backbone.JS, Underscore.JS, and Coffeescript), published the original [ruby-processing gem][gem]. It wraps Processing in a shim that makes it even easier to get started if you know Ruby. It has been since updated to use processing-2.2.1 by Martin Prout (final version using jruby-1.7.27 corresponding to ruby-1.9.3 syntax), NB: no more releases are expected, and ruby-processing is not compatible with processing-3.0+.

In 2015, Martin Prout (aka monkstone) published the [JRubyArt gem][jrubyart], loosely based on the original ruby-processing, but updated to use processing-3.5.3 and jruby-9.2+ (ruby2.4+ syntax)

### Why JRubyArt?

Since Processing already comes wrapped in an easy-to-use package, you may ask: "why should I bother with JRubyArt?"

The answer: if you know how to write Ruby, you can use Processing as a visual presentation layer of a much more complex program. Games, interactive art exhibits, innovative music projects, anything you can imagine; it's all at your fingertips.

Additionally, you don't have to declare types, voids, or understand the differences between floats and ints to get started, as you do in pure Processing.

Although there are some drawbacks to using the Ruby version Processing (slower start up time, and sometimes performance), having Ruby's API available to translate your ideas into sketches more than makes up for them.

Why was ruby-processing not updated to use processing3.0+? The [major changes][changes] between processing-2.2.1 and processing-3.0 are not backward compatible. Furthermore since JRubyArt was designed to use jruby-9.0.0.0 from the outset, it makes use of the more literate ruby-2.2 syntax (although the original ruby-processing might run with jruby-9.2+, the examples and the ruby-processing library are all based on ruby-1.9.3 syntax).

### Setup

Setting JRubyArt for the first time, can seem a bit involved (especially if you are addicted to rvm or rbenv). The JRubyArt gem relies on jruby-9.2++, processing-3.5.3, and a handful of other dependencies. Here's how to get them all installed and working on Windows.

Install [wget][wget] which is also available as [cygwin][cygwin] package, Oracle java (1.8.0.151+), and some version of ruby-2.2+ preferably jruby-9.2+. Do not use java-9 or greater see [processing-wiki][wiki]

### Processing

You can check to see what platforms are supported [here][platforms].
Download processing-3.5.3 from the [official website][official] and install, prefer to install in say `C:/Java/Processing` ie folders without special characters or spaces.  When you're done, make sure to take note of the directory you installed the app to complete the configuration.

__Finishing up__

Fire up processing, and use the processing ide to install the sound and video libraries as these are no longer included in the
download (but you will surely want them):-

`Sketch/Import Library/Add Library/Video` _ide menu_

### JRuby

It might actually be simpler to just install [jruby][jruby] on Windows rather
than struggle with MRI ruby, but you may also want to install [cygwin][cygwin] or similar in any case (cygwin has a wget package).

If you've already installed MRI ruby is also possible to run JRubyArt without a system install of jruby. But a jruby install might be needed to use JRubyArt with other gems eg toxiclibs.

Possibly the simplest way to get MRI ruby on windows is via [rubyinstaller][rubyinstaller], uses MinGW. Alternatively you can install [cygwin][cygwin] and use [rvm][rvm] to install MRI ruby.

### JRubyArt

Configuration:-

JRubyArt needs to know where you've installed processing, where your processing sketchbook lives (for the video and audio libraries etc), and whether you've done a system/user install of jruby.

Config file is `config.yml` in the `~/.jruby_art folder` so it can co-exist with a ruby-processing install (~/.rp5rc), it is advisable to have separate folders for processing-3.0 and processing-2.2.1 sketchbooks.

```yaml
# Example YAML configuration file for jruby_art on Windows
# K9_ROOT: "C:/Ruby22-x64/lib/ruby/gems/2.5.0/gems/jruby_art-1.6.0" # should not be necessary
PROCESSING_ROOT: "C:/Java/Processing" # just a suggestion
sketchbook: "C:/Users/USER/Documents/Processing" # adjust to suit your install
# JRUBY: false # uncomment to use jruby-complete by default especially if you haven't installed jruby
template: bare # use class or emacs for alternative templates
```

If you can/are using rvm or rbenv switch to using jruby-9.2+ then

```bash
gem install jruby_art
```

if you are brave (or sensible) and have done an independent jruby install

```bash
jruby -S gem install jruby_art # then install other gems eg toxiclibs the same way
```

but you might find regular MRI gem install works (also tends to be quicker)


After installing the the gem you can download and install jruby-complete,
this is not included in the gem, because it would make it too big, however providing you've got wget installed all you need to do is:-

```bash
k9 --install # downloads and installs jruby-complete and examples uses wget
```


### Running examples

To run a bunch of the samples as a demo:-

cd to say contributed folder (containing a Rakefile) and run `rake` see below

```bash
cd ~/k9_samples/contributed # for example
rake # autoruns files in contributed folder
k9 --run jwishy.rb # run the JWishy sketch, using an installed jruby
cd ~/k9_samples/processing_app/topics/shaders
rake # autoruns shader sketches
k9 --run monjori.rb # run the Monjori sketch
```

### Creating your own sketch

All we ask is that you obey the ruby filename convention (ie snakecase) and we can create a template sketch for you as follows:-

```bash
k9 --create fred_sketch 200 200 # creates a bare sketch fred_sketch.rb (see below)
vim fred_sketch.rb # other editors are available
:!k9 -r % # from vim runs the sketch
```

As a windows user you may find [atom][atom] to be a more suitable editor.

```ruby
def setup
  sketch_title 'Fred Sketch'
end

def draw

end

def settings
  size 200, 200
  # smooth # here
end
```

PS: `k9 -c fred` also works with a bare template defaults, to `size 200 200`

Read more about using the [processing api here][api]

[api]: {{site.github.url}}/methods/processing_api
[ben]:https://blog.engineyard.com/2015/getting-started-with-ruby-processing
[processing]:https://processing.org/
[gem]:https://rubygems.org/gems/ruby-processing
[jrubyart]:https://rubygems.org/gems/jruby_art
[changes]:https://github.com/processing/processing/wiki/Changes-in-3.0
[official]:https://processing.org/download/?processing
[platforms]:https://github.com/processing/processing/wiki/Supported-Platforms
[wiki]:https://github.com/processing/processing/wiki/Supported-Platforms#java-9
[jruby]:https://github.com/jruby/jruby/wiki/GettingStarted
[atom]:{{site.github.url}}/editors/atom
[cygwin]:https://www.cygwin.com/
[rubyinstaller]:https://rubyinstaller.org/downloads/
[rvm]:https://blog.developwithpassion.com/2012/03/30/installing-rvm-with-cygwin-on-windows/
[casey]:https://github.com/processing/processing/wiki/FAQ
[wget]:http://gnuwin32.sourceforge.net/packages/wget.htm
