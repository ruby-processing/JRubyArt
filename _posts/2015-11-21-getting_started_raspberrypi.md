---
layout: post
title:  "Getting Started on RaspberryPI"
date:   2018-05-31 06:24:13
categories: jruby_art update
permalink: /raspberrypi_started/
---

### Getting Started With JRubyArt (stolen from [Ben Lewis][ben]) ###

If you love to code because it is a creative process, then you should give JRubyArt a try because it can be used to [create music][sound], art, animations, [videos][video] and much more. Also since it is based on the latest [Processing][processing] you can access a vast range of libraries to make the difficult things easier.

### What Is Processing? ###

Processing is a simple language, based on Java, that you can use to create digital graphics. It's easy to learn, fun to use, and has an amazing online community comprised of programmers, visual artists, musicians, and interdisciplinary artists of all kinds.

Processing was built by Benjamin Fry and [Casey Reas][casey] ☯, two protegés of interdisciplinary digital art guru John Maeda at the MIT Media Lab.

Since the project began in 2001, it's been helping teach people to program in a visual art context using a simplified version of Java. It comes packaged as an IDE that can be downloaded and used to create and save digital art “sketches”.

In 2009, Jeremy Ashkenas (aka jashkenas, creator of Backbone.JS, Underscore.JS, and Coffeescript), published the original [ruby-processing gem][gem]. It wraps Processing in a shim that makes it even easier to get started if you know Ruby. It has been since updated to use processing-2.2.1 by Martin Prout (final version using jruby-1.7.27 corresponding to ruby-1.9.3 syntax), NB: no more releases are expected, and ruby-processing is not compatible with processing-3.0+.

In 2018, Martin Prout (aka monkstone) published a version of the [JRubyArt gem][jrubyart] that will run on the RaspberryPI, loosely based on the original ruby-processing, but updated to use processing-3.3.7 (and ruby-2.5 syntax)

### Why JRubyArt? ###

Since Processing already comes wrapped in an easy-to-use package, you may ask: "why should I bother with JRubyArt?"

The answer: if you know how to write Ruby, you can use Processing as a visual presentation layer of a much more complex program. Games, interactive art exhibits, innovative music projects, anything you can imagine; it's all at your fingertips.

Additionally, you don't have to declare types, voids, or understand the differences between floats and ints to get started, as you do in pure Processing.

Although there are some drawbacks to using the Ruby version Processing (slower start up time, and sometimes performance), having Ruby's API available to translate your ideas into sketches more than makes up for them.

Why was ruby-processing not updated to use processing3.0+? The [major changes][changes] between processing-2.2.1 and processing-3.0 are not backward compatible. Furthermore since JRubyArt was designed to use jruby-9.0.0.0+ from the outset, it makes use of the more literate ruby-2.5 syntax (although the original ruby-processing might run with jruby-9.2.0.0, the examples and the ruby-processing library are all based on ruby-1.9.3 syntax).

### Pure JRubyArt Setup RaspberryPI ###

The easiest way to get started is use the pi.processing image on RaspberryPI (preferably mode 3B+) see [pi.processing website][website] for instructions. Before you start in earnest it is good to avoid unnecessary document builds so create `.gemrc` with following content:-

```yaml
---
  gem: -no-documents
```

You should probably do `gem update --system`
```bash
sudo gem update --system
```

Install JRubyArt

```bash
gem install jruby_art
```
Install samples and jruby-complete

```bash
k9 --install
```

To check config do

```bash
k9 --check
```

[website]:https://pi.processing.org/get-started/
[api]: {{site.github.url}}/methods/processing_api
[ben]:https://blog.engineyard.com/2015/getting-started-with-ruby-processing
[processing]:https://processing.org/
[gem]:https://rubygems.org/gems/ruby-processing
[jrubyart]:https://rubygems.org/gems/jruby_art
[changes]:https://github.com/processing/processing/wiki/Changes-in-3.0
[official]:https://processing.org/download/?processing
[platforms]:https://github.com/processing/processing/wiki/Supported-Platforms
[editor]:http://ruby-processing.github.io/JRubyArt/editors.html
[sound]:https://monkstone.github.io/_posts/minim
[video]:https://monkstone.github.io/_posts/create_video
[casey]:https://github.com/processing/processing/wiki/FAQ
