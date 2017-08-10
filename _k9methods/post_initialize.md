---
layout: post
title:  "post_initialize"
---
We have provided a `post_initialize` for a JRubyArt sketch, which allows you to send parameter options to your sketch via initialize, and really only makes sense when you explicitly create an instance of your sketch. The `post_initialize` method is a hook that avoids you needing to call super on initialize. At present we haven't got an examples to show you, but see this is an alternative
[hook example][hook].

[hook]:https://github.com/ruby-processing/JRubyArt-examples/tree/master/processing_app/topics/ruby_hook
