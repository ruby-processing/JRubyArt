---
layout: post
title:  'Using Executable Gems'
keywords: gem, jruby_art
---
To use any executable it needs to be on your path (unless you give the full path, and that is hardly convenient). For this purpose it is imporatant to know where gems get installed on your system. You should prefer to install gems locally (ie in your home directory) eg `/home/tux/.gem/ruby/2.5.0` in which case the path to binaries will be `/home/tux/.gem/ruby/2.5.0/bin` so then in your configuration file you want to add this to your `PATH` environmental variable.

### ~/.bashrc archlinux (and some other linux)

or ~/.profile (mint linux etc)

```bash
export GEM_HOME="/home/tux/.gem/ruby/2.5.0"
export GEM_PATH="/home/tux/.gem/ruby/2.5.0"
export PATH="${PATH}:${GEM_PATH}/bin"
```

For MacOS it is very similar just edit `~/.bash_profile` if required

Windows has a gui that allows you to add to the PATH environmental variable (if required)

The executable for JRubyArt is `k9` but generally `k9 -r my_sketch.rb` or `k9 -w my_sketch.rb` to run watch sketches. Since we are running a two stage process with JRubyArt you can start the process with MRI ruby, but the sketch gets run by `jruby` directly or via `java` and `jruby-complete`.
