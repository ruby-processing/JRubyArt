---
layout: post
title:  "Getting Started On Windows"
date:   2019-09-28 06:00:00
categories: jruby_art update
permalink: /windows_start/
---
### Getting Started With JRubyArt ###

If you love to code because it is a creative process, then you should give JRubyArt a try because it can be used to create music, art, animations, videos and much more. Also since it is based on the latest [Processing][processing] you can access a vast range of libraries to make the difficult things easier.

### Why JRubyArt? ###

Since Processing already comes wrapped in an easy-to-use package, you may ask: "why should I bother with JRubyArt?"

The answer: if you know how to write Ruby, you can use Processing as a visual presentation layer of a much more complex program. Games, interactive art exhibits, innovative music projects, anything you can imagine; it's all at your fingertips.

Additionally, you don't have to declare types, voids, or understand the differences between floats and ints to get started, as you do in pure Processing.

Although there are some drawbacks to using the Ruby version Processing (slower start up time, and sometimes performance), having Ruby's API available to translate your ideas into sketches more than makes up for them.


### Setup

Setting JRubyArt since JRubyArt-2.0 does not require a vanilla processing install, but still requires some configuration to point to your libraries folder.

Install [wget][wget] which is also available as [cygwin][cygwin] package, openjdk (11.0.3+), and some version of ruby-2.6+ preferably jruby-9.3+. If you encounter linkage problems it might be worth looking at [Eclipse Temurin][adopt] distribution or OpenJ9.

### JRuby

It might actually be simpler to just install [jruby][jruby] on Windows rather
than struggle with MRI ruby, but you may also want to install [cygwin][cygwin] or similar in any case (cygwin has a wget package).

If you've already installed MRI ruby is also possible to run JRubyArt without a system install of jruby. But a jruby install might be needed to use JRubyArt with other gems eg toxiclibs.

Possibly the simplest way to get MRI ruby on windows is via [rubyinstaller][rubyinstaller], uses MinGW. Alternatively you can install [cygwin][cygwin] and use [rvm][rvm] to install MRI ruby.

### JRubyArt

Installing JRubyArt assumes you have installed a recent version of ruby (which can be either MRI ruby (preferably 2.5.\* and not 2.7.\* or safer JRuby-2.9.19.0)

```bash
gem install jruby_art
```

If you __haven't__ installed JRubyArt before, the simplest way to set the configuration, and to install samples is:-

```bash
k9 --install # no arguments
```

this also installs `jruby-complete`

If you __have__ installed JRubyArt before, the simplest way to set the configuration is:-

```bash
k9 -if config
```

Using `-f` or `--force` flag forces the removal of the previous configuration.

To check your configuration:-

```bash
k9 --check # or -?
```

The config file is `config.yml` in the `~/.jruby_art folder`, which you should edit if required.

To explore command line options:-

```bash
k9 --help # or k9 -h
```

#### Running examples

To explore the installed examples:-
```bash
cd ~/k9_samples
rake # to run examples randomly as a demo
# or check available tasks with
rake --tasks
# use a task to randomly run a group of sketches eg
rake shaders # runs the shader examples
```
#### Create your own sketches

To create a simple sketch:-
```bash
k9 -c fred 200 200 # sketch name=Fred width=200 height=200 mode=default
k9 -c my_sketch 300 300 p2d # sketch name=MySketch width=300 height=300 mode=P2D
```
Edit `fred.rb` or `my_sketch.rb` with your favourite editor preferably `vim`, `emacs` or `atom`.

To run sketch using the command line

```bash
k9 -r fred.rb
```

To run a sketch from editor see [editors][editors]

Read more about using the [processing api here][api]

#### Processing

Installing processing is optional but you could us it download the processing.org and contributed libraries.
You can check to see what platforms are supported [here][platforms].

Read more about using the [processing api here][api]

[adopt]:https://adoptium.net/
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
[editors]: {{site.github.url}}/started/
