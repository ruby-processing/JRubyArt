---
layout: post
title:  "Emacs"
keywords: editor, ide, ruby, jruby_art, emacs
permalink: /emacs/
---

By contributor Jeremy Laviole (aka [poqudrof](https://github.com/poqudrof))

Emacs looks like an old editor, but is has loads of very good features. And as it is based on an interpreted language (ELisp) it is quite good for interpreted languages.

### Setup

1. Install emacs25.
2. Install the emacs packages [inf-ruby](https://github.com/nonsequitur/inf-ruby) and [rvm](https://github.com/senny/rvm.el)
3. Add this to your .emacs

``` lisp
(setq auto-mode-alist (cons '("\\.pde$" . java-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.pde\\w?" . java-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.vert\\w?" . c-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.glsl\\w?" . c-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.frag\\w?" . c-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist
	     '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
(add-to-list 'auto-mode-alist
	     '("\\(Capfile\\|Gemfile\\(?:\\.[a-zA-Z0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

;; Get the Packages for emacs25.

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))

(package-initialize)

## command to load JRuby
(defun jruby ()
  (interactive)
  (inf-ruby "jruby"))

## F7 is my personnal choice.
(global-set-key [f7]     'jruby)

## If you use RVM, uncomment this.
##(require 'rvm)
##(rvm-use-default) ;; use rvm's default ruby for the current Emacs session
```

A reminder of the commands to install the packages :

* package-refresh-contents
* package install  all of this one by one: inf-ruby, rvm

## Try it !

1. Launch emacs, open k9_samples/contributed/jwishy.rb
2. Add this at the beginning of the file :

```ruby
require 'jruby_art'
require 'jruby_art/app'

Processing::App::SKETCH_PATH = __FILE__

class MyApp < Processing::App
```

Add this at the end of the file : 

```ruby
end

MyApp.new unless defined? $app
```

The sketch is ready.

## Start the REPL

1. Hit [F7] to start Ruby.
2. you can send buffers to the REPL with [C-c][C-l], or the selected code with [C-c][C-r]
3. Go to the jwishy.rb buffer and do  [C-c][C-l] i.e. (control + c, control + l).
4. Have fun with the sketch ! You can change @x_wiggle or @y_wiggle and hit [C-c][C-l] to update in real time.
5. If you have PRY, you can also interact easily with the sketch values...
``` ruby
cd $app   # go in the sketch
@x_wiggle # get the wiggle value
@x_wiggle = 400  # set the value
@y_wiggle = 300
```

## Use with PRY

Edit the file ~/.irbrc and put this in it:

```ruby
require 'rubygems'
require 'pry'
Pry.start
exit
```

Edit files with emacs with Pry, put this in ~/.pryrc  

```ruby
Pry.editor = "emacs"
```
