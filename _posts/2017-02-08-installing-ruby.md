---
layout: post
title:  "Installing Ruby"
date:   2017-02-08 05:15:13
categories: jruby_art update
permalink: /installing_ruby/
---

## Installing ruby

There may be problems using the latest MRI ruby releases (should work OK with ruby-2.6), default setup is to use most recent JRuby, rather than a combination of MRI ruby and JRuby-Complete.

### Managers

Many Rubyists use Ruby managers to manage multiple Rubies. They confer various advantages but are not officially supported. Their respective communities are very helpful, however do not use them unless you absolutely must, they are generally an absolute pain and not needed for JRubyArt (which ultimately runs directly from `java` when using `jruby-complete` or from an installed `jruby` over which rvm and rbenv have no control over, you have been warned)

## Installing jruby

For windows see [JRuby wiki][wiki]

For Arch Linux

```bash
$ sudo pacman -S jruby
```

This should install the latest stable JRuby version.

For Debian linux

Get the latest version from [http://jruby.org/download][download]

```bash
cd /opt
tar xzvf /pathToDownload/jruby-bin-9.3.x.x.tar.gz
```

You could the use the excellent update-alternatives to provide symbolic links to ruby, jruby, jirb jgem etc.

For MacOS user using the Homebrew as a package manager.

```bash
$ brew install jruby
```

This will again generally install the the latest jruby for you.

### Managers

As far as I know rvm and rbenv are completely useless with jruby (further bundler is also as good as useless for JRubyArt)

[download]:http://jruby.org/download
[installer]:https://rubyinstaller.org/
[wiki]:https://github.com/jruby/jruby/wiki/GettingStarted
