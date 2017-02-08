---
layout: post
title:  'Using Executable Gems'
keywords: gem, jruby_art
---
To use any executable it needs to be on your path (unless you give the full path, and that is hardly convenient). For this purpose it is imporatant to know where gems get installed on your system. You should prefer to install gems locally (ie in your home directory) eg `/home/tux/.gem/ruby/2.4.0` in which case the path to binaries will be `/home/tux/.gem/ruby/2.4.0/bin` so then in your configuration file you want to add this to your `PATH` environmental variable.

### ~/.bashrc archlinux (and some other linux)

or ~/.profile (mint linux etc)

```bash
export GEM_HOME="/home/tux/.gem/ruby/2.4.0"
export GEM_PATH="/home/tux/.gem/ruby/2.4.0"
export PATH="${PATH}:${GEM_PATH}/bin"
```

For MacOS it is very similar just edit `~/.bash_profile` if required

Windows has a gui that allows you to add to the PATH environmental variable (if required)
