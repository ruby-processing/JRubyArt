---
layout: page
title:  "What is JRubyArt?"
permalink: about
---

  - [JRubyArt](https://github.com/ruby-processing/JRubyArt) allows you
    to code [processing](https://processing.org/) sketches in regular
    ruby (it supersedes ruby-processing for processing-3.0+).

  - Vanilla processing is essentially Java with an antlr \[1\]
    pre-processor to make writing code simpler (in the processing ide), although
    it is debatable whether whether `color` should have ever been a type!!!.

  - [JRubyArt](https://github.com/ruby-processing/JRubyArt) is able to
    emulate the simplicity of vanilla processing, by using JRuby \[2\]
    to load regular processing jars into a ruby runtime environment.

  - You can write JRubyArt code in any editor that supports ruby syntax,
    however the [atom](https://atom.io/) editor \[3\] has a plugin that
    allows you to run / watch processing sketches without leaving the
    editor.

  - Vim \[4\] and Emacs \[5\] can also run sketches without leaving the
    editor, in addition both can be used to edit live JRubyArt code live
    from pry \[6\].

<!-- end list -->

1.  ANTLR (ANother Tool for Language Recognition) is a powerful parser
    generator for reading, processing, executing, or translating
    structured text or binary files.

2.  JRuby is an implementation of the Ruby programming language atop the
    Java Virtual Machine

3.  A hackable text editor for the 21st Century

4.  Vim is a highly configurable text editor for efficiently creating
    and changing any kind of text

5.  The features of GNU Emacs include. Content-aware editing modes,
    including syntax coloring, for many file types. Complete built-in
    documentation

6.  Pry is a powerful alternative to the standard IRB shell for Ruby. It
    is written from scratch to provide a number of advanced features
