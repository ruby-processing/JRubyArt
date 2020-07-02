---
layout: post
title:  "Getting Started on Linux"
date:   2019-09-28 06:00:00
categories: jruby_art update
permalink: /linux_started/
---

### Getting Started With JRubyArt ###

If you love to code because it is a creative process, then you should give JRubyArt a try because it can be used to create music, art, animations, videos and much more. Also since it is based on the latest [Processing][processing] you can access a vast range of libraries to make the difficult things easier.

### Why JRubyArt? ###

Since Processing already comes wrapped in an easy-to-use package, you may ask: "why should I bother with JRubyArt?"

The answer: if you know how to write Ruby, you can use Processing as a visual presentation layer of a much more complex program. Games, interactive art exhibits, innovative music projects, anything you can imagine; it's all at your fingertips.

Additionally, you don't have to declare types, voids, or understand the differences between floats and ints to get started, as you do in pure Processing.

Although there are some drawbacks to using the Ruby version Processing (slower start up time, and sometimes performance), having Ruby's API available to translate your ideas into sketches more than makes up for them.


### Pure JRuby Setup Archlinux ###

Install Software as required:-

Currently stock OpenJDK12 has a linking problem affecting P2D and P3D sketches, so install [adopt-openjdk12][adopt] instead.

```bash
sudo pacman -S ruby # installs ruby-2.6
sudo pacman -S jruby # installs jruby-9.2.11.0
```

Install gems as required
```bash
gem install jruby_art
gem install toxiclibs # optional
gem install pbox2d # optional
gem install geomerative # optional
```
If you wish install vanilla processing, but it is not required since JRubyArt-2.0.

If you __haven't__ installed JRubyArt before you should:-

```bash
k9 --install # no arguments
```
To configure JRubyArt, install samples, and also install jruby-complete

If you __have__ installed JRubyArt before you should:-

```bash
k9 -fi config # -f or --force flags force removal of previous configuration
```

Use:-

```bash
k9 --help # or -h to show command line options
# or
k9 --check # or -? to check configuration
```

### Pure JRuby Setup Debian (Mint, Ubuntu) ###

#### Java ####

Unfortunately there is currently a linker problem with stock OpenJDK on linux so we are recommending installing [adoptopenjdk][adopt] version which is available as a deb package. But you have to add the repository to your setup as follows:-

```bash
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -

sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

sudo apt-get install -y software-properties-common

sudo apt-get update

sudo apt-get install openjdk-12-hotspot # or adoptopenjdk if you have linker issues.
```

Use debian `update-alternatives` tool to manage configuration for java:-
```bash
sudo update-alternatives --config java # to configure if required
sudo update-alternatives --config javac # to configure if required
sudo update-alternatives --config jar # to configure if required
```
#### MRI Ruby

Install MRI ruby (should be at least ruby-2.5, but definitely not 2.7), if you are not using `rvm` or `rbenv`, then you should create a home in a local folder to store your gems eg `~/.gem/ruby/2.5.0` to store your gems:-

```bash
mkdir -p ~/.gem/ruby/2.5.0
```

To get `gem` command to use this location set `GEM_HOME` and `GEM_PATH` in `~/.profile` and add the `GEM_PATH/bin` to `PATH` as below:-

```bash
export GEM_HOME="$HOME/.gem/ruby/2.5.0"
export GEM_PATH="$HOME/.gem/ruby/2.5.0"
# set PATH so it includes user's private bin directories
export PATH="$HOME/bin:$HOME/.local/bin:$GEM_PATH/bin:$PATH"
```

#### JRuby

Download and install latest jruby (in the `/opt` folder makes sense)

Use `update-alternatives` to install and maintain configuration eg for jruby:-
```bash
sudo update-alternatives --install /usr/bin/jruby jruby /opt/jruby-9.2.12.0/bin/jruby 100
sudo update-alternatives --config jruby # to configure if required
```

#### JRubyArt

Install gems as required
```bash
gem install jruby_art
gem install toxiclibs # optional
gem install pbox2d # optional
gem install geomerative # optional
```
If you wish install vanilla processing, but it is not required since JRubyArt-2.0.

If you __haven't__ installed JRubyArt before you should:-

```bash
k9 --install # no arguments
```
To configure JRubyArt, install samples, and also install jruby-complete

If you __have__ installed JRubyArt before you should:-

```bash
k9 -fi config # -f or --force flags force removal of previous configuration
```

Use:-

```bash
k9 --help # or -h to show command line options
# or
k9 --check # or -? to check configuration
```

Installing JRubyArt assumes you have installed a recent version of ruby (which can be either MRI ruby or JRuby)

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

To explore the installed examples:-
```bash
cd ~/k9_samples
rake # to run examples randomly as a demo
# or check available tasks with
rake --tasks
# use a task to randomly run a group of sketches eg
rake shaders # runs the shader examples
```

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

#### Processing

Installing processing is optional but you could us it download the processing.org and contributed libraries.
You can check to see what platforms are supported [here][platforms].


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
[adopt]:https://adoptopenjdk.net/
