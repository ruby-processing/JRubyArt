---
layout: post
title:  "Atom"
permalink: /editors/atom/
keywords: ide, ruby, jruby_art, atom
---
Unless you are a vim or emacs aficionado you should probably prefer atom.

### Install Atom ###

See [website][atom] (or scroll to bottom of [releases page for downloads][releases] on github)

For linux ignore any distro version and download latest version:-

```bash
sudo dpkg --install atom-amd64.deb # debian, mint, ubuntu
sudo pacman -S atom # Archlinux currently installs 1.35.0
```

MacOS/Windows users could just download direct (or homebrew on MacOS)

Tough luck if you want the 32 bit version on debian linux

### Install Packages ###

From the atom editor install the `atom-k9` package by [Martin Prout (monkstone)][atom-k9]

While you are at install the `language-jruby-art` package [also by Martin Prout][language] for code snippets (includes a `bare` JRubyArt sketch)

Also install `set-syntax` package by Lee Dohm to allow easy setting of buffer syntax

### Watching Sketches (a pseudo REPL) ###

_Important_

To watch sketches you should create a new folder (_to avoid watching too many files_) and to reliably pick up the local environment (_eg path to `k9`_) you should start atom from a terminal (_gnome-terminal linux, mintty cygwin_).

```bash
mkdir watch # create a new folder
cd watch # navigate to folder
touch my_sketch.rb # create an empty file
atom my_sketch.rb # fire up atom from command line (to pick up local environment)

```

Make sure you are in `JRuby Art` edit mode (_click on bottom right hand corner to choose_).

Or if you've installed `set-syntax` load command palette with `ctrl-shift-p` and enter `ssjru` to choose.

The use `bare` snippet to create sketch, NB: below gif has not been updated to show red `JRA` label that helpfully highlights core JRubyArt snippets

![enter 'bare']({{ site.github.url }}/assets/animation.gif)

Use `ctrl-s` to save.

For a pseudo `REPL` select watch from menu or `ctrl+shift+alt+w`. Then the sketch will reload on `ctrl-s` after edit.

If you want to avoid need to start from a terminal, create a symbolic link to a regular system path to `k9` (eg /usr/local/bin/k9), this easily done/managed on debian linux  (_with `update-alternatives`_)

### To run a sketch ###

To simply run a sketch, navigate to the sketch (file) and use either JRubyArt menu, or `ctrl+alt+b`.

### To close a running sketch ###

Close the console from the JRubyArt menu (or just close the sketch window)

### What's it look like ###

![atom-k9]({{ site.github.url }}/assets/jwishy.png)

### Expanding / Modifying snippets ###

Navigate to ~/.atom/packages/language-jruby-art/snippets and edit `language-jruby-art.cson`

### Linter Ruby Leek package etc

Fans of Sandi Metz will may want to experiment with the linter-ruby-reek and rubocop packages, the latter v. useful for detecting stupid coding errors.

[language]:https://atom.io/packages/language-jruby-art
[atom-k9]:https://atom.io/packages/atom-k9
[atom]:https://atom.io/
[releases]:https://github.com/atom/atom/releases/tag/v1.35.0
