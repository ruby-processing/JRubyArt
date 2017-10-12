---
layout: post
title:  "Vim"
permalink: /editors/vim/
keywords: editor, ide, ruby, jruby_art, vim, emacs, jedit
---
Unless you are a vim or emacs aficionado you should probably prefer atom. However vim can be an excellent choice for linux and mac users, it is lighweight (runs from the console) commands available from vim:-
```bash
:!k9 --run %   # will run the sketch
```

### Watching Sketches (a pseudo REPL) ###

_Important_

To watch sketches you should create a new folder (_to avoid watching too many files_).

```bash
mkdir watch # create a new folder
k9 --create my_sketch 200 200 # create `my_sketch.rb` default is a bare sketch (set in config.yml)
vim my_sketch.rb # fire up atom from command line (to pick up local environment)
k9 --watch my_sketch.rb
```
Then in a second console

```bash
vim watch/my_sketch.rb # edit from relative path is fine
```
On save `:w`sketch will re-load (no need to quit vim)

### Live coding with Pry ###

To do live editing with pry you should install either [emacs][emacs] or vim, but vim is probably the best. You also need to install the pry gem for use with jruby:-

```bash
jgem install pry
# or jruby -S gem install pry
# or if you must use rvm or rbenv not recommended
```

To make life easy change your `~/.jruby_art/config.yml` to `template: class` from `template: bare`.

You must configure pry to set vim as the pry editor `echo "Pry.config.editor = 'vim'" > ~/.pryrc`.

Now you are set create a test sketch `k9 -c fred 200 200`

To start the live session `k9 --live fred.rb`

This should start the sketch and boot into a `pry` session:-

![pry session]({{ site.github.url }}/assets/fred_pry.png)

To get the code listing as shown above enter `$` at the `pry` prompt, to edit the empty draw method `edit -p Fred#draw` at the `pry prompt` once completed entry leave the `vim` editor with `:wq`
 (or `:wqa` to save all changed buffers) and the sketch will be redrawn to to reflect the new content. But the beauty of the setup is that you can repeat the exercise `edit -p Fred#draw` will reload vim with the `saved content` that you can continue to edit.

![re-edit pry session]({{ site.github.url }}/assets/edit_p.png)

You can read more about [pry integration][pry] by following link.

### Other advantages of vim ###

Also because vim is run from the console it is so easy to run old friends like `rubocop` or `reek` on your sketch code.

If you are millenial and allergic to the command line install [atom][atom], emacs is only for hardcore geeks. As yet I don't think pry supports `atom` as a editor.

[emacs]:{{ site.github.url }}/emacs/
[atom]:{{ site.github.url }}/atom
[pry]:https://github.com/pry/pry/wiki/Editor-integration
