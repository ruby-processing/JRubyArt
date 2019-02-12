---
layout: post
title:  "Getting Started on RaspberryPI"
date:   2018-05-31 06:24:13
categories: jruby_art update
permalink: /raspberrypi_started/
---

### Getting Started With JRubyArt on RaspberryPI ###

Thanks to Sam Aarons [SonicPI][sonic_pi], you may already have been introduced to ruby, now there is an opportunity to extend your creative skills in ruby.
JRubyArt can be used to create art, animations, videos and much more. Also since it is based on the latest [Processing][processing] you can access a vast range of processing libraries that make difficult things easier (_some available as ruby gems_).

### Installing Processing on the RaspberryPI ###

By far the easiest and most reliable way to get started is to use the processing.org custom raspbian image. You should download the processing raspbian image [here][image] and write the image to a spare SD card, see [pi.processing website][website]. If you want to use a usbstick / usbdrive you need to tell your raspberrypi to do a usb boot (this is one time and and irreversible step so not for noobs), see [here][usbstick], there are plenty of tools for writing images to usb drives (eg mintstick on mint linux).

### Connecting WiFi ###

It is assumed that you will use wifi (instead of ethernet cable) to connect to the internet, so once you have booted the processing raspbian image use raspi-config to set your wifi region and enter your wifi connection credentials. Once you have connected it is worth updating raspi-config, although that will mean re-entering your wifi connections, but this time you will be able to use the gui. Clicking on the wifi connection widget you will get a choice of connections choose yours and re-enter credentials. You can set a unique network hostname from the RaspberryPI configuration gui.

### Preparing to install gems ###

It is normal to install gems to a local folder, but you need to define the GEM_HOME to do so, what I usually do is to modify `~/.profile` to modify the local bash environment see my `~/.profile`:-

```bash
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export GEM_HOME="/home/pi/.gem/ruby/2.3.0"
export GEM_PATH="/home/pi/.gem/ruby/2.3.0"
export PATH="${PATH}:${GEM_PATH}/bin"
```

Note this profile is not immediately available to your `shell` but you could do `source ~/.profile` to make it so or re-boot.
NB: be very careful here an invalid `.profile` may prevent you from logging into raspberrypi.

It is also worth creating a `~/.gemrc` if only to avoid downloading unnecessary gem documentation (wastes time, and takes up space)

```yaml
---
  gem:
    -no-document
```

You should then do a gem system update:-

```bash
sudo gem system --update
```
Now you are ready to install JRubyArt

### Installing JRubyArt ###

```bash
gem install jruby_art
k9 --install # should create config.yml for you since JRubyArt-1.5.0
# also installs JRuby-Complete and examples in ~/k9_samples
k9 --check
```
The k9 --check should pass with `PROCESSING_ROOT: "/usr/local/lib/processing-3.5.3"` and `JRUBY: false`

With this configuration JRubyArt _knows_ where to locate processing jars, and that we wish to JRubyComplete, rather than an installed JRuby.

Now you are good to go `cd k9_samples` and `rake` to start a sequential demo of some sketches (_NB: some won't work on raspberrypi_), closing one sketch starts another.

### Creating your own sketches ###

It makes sense to create a directory in which to create your sketches, the you can use `k9 --create` tool to make your own

```bash
mkdir my_sketches
cd my_sketches
k9 --create my_sketch 300 300
```
This creates a blank sketch `my_sketch.rb` which is also a valid sketch (can be run) but is not too interesting. I suggest using vim as your JRubyArt editor, but you could use geany. Actually the simplest sketch you could create with JRubyArt is just one line (similar to SonicPI and vanilla processing) here is an example:-

```ruby
background 200, 0, 0
```
Have fun exploring!!!

### Some gems to install ###

rubocop ..._static code analysis_

[wordcram](https://github.com/ruby-processing/WordCram/)

[toxiclibs](https://github.com/ruby-processing/toxicgem/)

[geomerative](https://ruby-processing.github.io/geomerativegem/)

[sonic_pi]:https://sonic-pi.net/
[website]:https://pi.processing.org/get-started/
[usbstick]:https://www.raspberrypi.org/documentation/hardware/raspberrypi/bootmodes/msd.md


[image]:https://github.com/processing/processing/releases/download/processing-0264-3.4/processing-3.5.3-linux-raspbian.zip
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
