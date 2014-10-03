## JRubyArt


Is a development fork of [ruby-processing][]

First you should install processing-2.2.1

Then create a `~/.k9rc` config file, here is
what mine looks like on Arch-linux

```ruby
---
PROCESSING_ROOT: /usr/share/processing
```

To compile extensions `jruby -S rake compile`

To build gem `jruby -S rake package`

To install `gem install pkg/jruby_art-0.1.2.gem`

To create a new blank sketch

```bash
k9 create my_app 200 200
```

[Contributing][]

[License][]

[Acknowledgements][]


[Acknowledgements]:ACKNOWLEDGEMENTS.md
[Contributing]:CONTRIBUTING.md
[License]:LICENSE.md
[processing]:https://github.com/processing/processing
[ruby-processing]:https://github.com/jashkenas/ruby-processing
