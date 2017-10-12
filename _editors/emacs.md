---
layout: post
title:  "Emacs"
keywords: editor, ide, ruby, jruby_art, emacs
permalink: /emacs/
---

Unless you are a `emacs` aficionado you should probably prefer atom. However `emacs` is pretty powerful but a nightmare to configure cf atom. However along with `vim` it is probably the only editor that you can properly integrate with `pry`. Because it not as lightweight as vim it is just as well that you do not need not close `emacs` when live editing with pry.

```bash
jgem install pry
# or jruby -S gem install pry
# or if you must use rvm or rbenv not recommended
```

To make life easy change your `~/.jruby_art/config.yml` to `template: class` from `template: bare`.

### configure the editor
Setting editor in `~/.pryrc`

```bash
`echo "Pry.config.editor = 'emacs'" > ~/.pryrc`.
```

### start emacs in server mode

M-x server-start (alt-x)

Install the pry gem for use with jruby:-

Now you are set create a test sketch `k9 -c fred 200 200` and start the live session `k9 --live fred.rb`

This should start the sketch and boot into a `pry` session:-

![pry session]({{ site.github.url }}/assets/emacs_p.png)

To get the code listing as shown above enter `$` at the `pry` prompt, to edit the empty draw method `edit -p Fred#draw` at the `pry prompt` once completed save the sketch with Cx Cc (ctrl-x, ctrl-c) and the sketch will be redrawn to to reflect the new content. But the beauty of the setup is that you can repeat the exercise `edit -p Fred#draw` will reload emacs buffer with the `saved content` that you can continue to edit.

### Further emacs configuration

Emacs fanboys interested in further customising emacs for use with JRubyArt should see Jeremy Laviole article on the [wiki][wiki]. If you go down the Jeremy Laviole route you can  change your `~/.jruby_art/config.yml` to `template: emacs` from `template: bare`. Otherwise read about pry integration [here][pry].

[pry]:https://github.com/pry/pry/wiki/Editor-integration

[wiki]:https://github.com/ruby-processing/JRubyArt/wiki/Using-emacs-as-your-JRubyArt-Ide
