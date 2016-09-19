---
layout: post
title:  "JRubyArt with atom"
date:   2016-08-20 08:07:00
categories: jruby_art update
permalink: /atom/
keywords: ide, ruby, jruby_art, atom
---
### Install Atom ###

See [website][atom] (or scroll to bottom of [releases page for downloads][releases] on github)

For linux ignore any distro version and download latest version (at least 1.10.2) and:-

```bash
sudo dpkg --install atom-amd64.deb # debian, mint, ubuntu
sudo pacman -S atom # Archlinux currently installs 1.10.2
```

Mac/Windows users could just download direct (or homebrew on Mac)

Tough luck if you want the 32 bit version on debian linux

### Install Package ###

From the atom editor install the `atom-k9` package by [Martin Prout (monkstone)][atom-k9]

While you are at install the `language-jruby-art` package [also by Martin Prout][language] for code snippets (including a `bare` JRubYArt sketch)

### Running Sketches ###

_Important_

To reliably pick up the local environment (eg path to `k9`) you should start atom from a terminal (gnome-terminal linux, mintty cygwin).

The alternative is to create a symbolic link to a regular system path to `k9` (eg /usr/local/bin/k9) this easily done/managed on debian linux.

To run the current sketch (file) use either menu, or `ctrl+alt+b`.  For a pseudo `REPL` select watch from menu or `ctrl+shift+alt+w`. Then the sketch will reload on save after `edit`.


### What's it look like ###

![atom-k9]({{ site.github.url }}/assets/jwishy.png)

[language]:https://atom.io/packages/language-jruby-art
[atom-k9]:https://atom.io/packages/atom-k9
[atom]:https://atom.io/
[releases]:https://github.com/atom/atom/releases/tag/v1.10.2
