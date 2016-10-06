---
layout: post
title:  "Vim"
permalink: /vim
keywords: editor, ide, ruby, jruby_art, vim, emacs, jedit
---

Is an excellent choice for linux and mac users, it is lighweight (runs from the console) commands available from vim:-
{% highlight bash %}
:!k9 --run %   # will run the sketch
:!k9 --watch % # reloads and run sketch on save
{% endhighlight %}

To do live [live editing with pry][pry] you should install either [emacs][emacs] or vim, but vim is probably the best. __Note:__ sketches created with `template: class` work best for live editing.

Do `echo "Pry.config.editor = 'vim'" > ~/.pryrc` to set vim as the pry editor.

Then when you `k9 --live my_sketch.rb` you will be able edit using vim.

Also because vim is run from the console it is so easy to run old friends like `rubocop` or `reek` on your sketch code.

If you are millenial and allergic to the command line install [atom][atom], emacs is only for hardcore geeks. As yet I don't think pry supports `atom` as a editor.

[emacs]:{{ site.github.url }}/emacs/
[atom]:{{ site.github.url }}/atom
[pry]:https://github.com/ruby-processing/JRubyArt/wiki/Live-Coding
