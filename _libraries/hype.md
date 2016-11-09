---
layout: post
title:  "Hype Library Examples<sup>5</sup>"
keywords: library, java, framework, hype, processing

---
<sup>5</sup><i>A vanilla processing library</i> that you may need to [compile and install][build] yourself.  You could even use a [polyglot maven][polyglot] (see pom.rb) to build the jar, use a local processing core.jar if you want the latest version. I've put SNAPSHOT in version because library claims to be under heavy development (the commit history would argue otherwise).

Here is an index of my blogposts about using the [Hype processing framework][] by Joshua Davis in JRubyArt. The code [examples][] are included with the JRubyArt examples.

1. [A Basic Sketch](https://monkstone.github.io/jruby_art/update/2016/04/18/hype.html)

   Here we are reminded that we cannot use naked web-color strings in JRubyArt (in vanilla processing these get pre-processed anyway). Further vanilla processing (and java) use signed `int` (incompatible with ruby Fixnum) which is why we use `fill(color('#242424'))` for `fill(#242424)` see
   [alternatives][color]
2. [Using Callbacks](https://monkstone.github.io/jruby_art/update/2016/04/20/hype_advanced.html)

   This sketch shows how you can use the magic of JRuby to replace anonymous callbacks with a block.
3. [A GLSL Examples](https://monkstone.github.io/jruby_art/update/2016/04/22/hype_scanlines_glsl.html)

   This sketch shows you a neat method to initialize a palette of `web-colors` (_that Joshua Davis is sure keen on his `web-colors`_), also introduces the `HTimer` class (but I'm not sure that it is either required or actually gets used in this sketch).
4. [Using nested callbacks](https://monkstone.github.io/nested_callbacks)

   This sketch is another example showing how you can use the magic of JRuby to replace anonymous callbacks with a block. Even when those callbacks are nested, as in this sketch. The sketch also features the use of the `HTimer` class.
5. [3D Orbiter](https://monkstone.github.io/jruby_art/update/2016/04/23/orbiter.html)

   This sketch features use of the `HBundle`, `HOrbiter3D` and `HSphere` classes.

6. [Random Trigger](https://monkstone.github.io/jruby_art/update/2016/05/15/random_trigger.html)

   This sketch features a callback on the `HRandomTrigger` class from the hype library.  Also includes a guide to using of the new `web_to_color_array` method to create a hash palette from web-color strings.

7. [A Grid Layout Sketch](https://monkstone.github.io/jruby_art/update/2016/05/27/grid_layout.html)

   A simpler sketch that manages without callbacks.

8. [A Hype Attractor Sketch](https://monkstone.github.io/jruby_art/update/2016/05/26/attractor.html)

   Yet another sketch that shows how you can use the magic of JRuby to replace an anonymous callback with a block.

9. [A Hype Swarm Sketch](https://monkstone.github.io/jruby_art/update/2016/05/24/hype_swarm.html)

   This sketch features the use of a ruby `proc` to implement a callback (in place of a ruby `lambda`) see `on_anim`

10. [A Hype Colorist Sketch](https://monkstone.github.io/jruby_art/update/2016/06/08/colorist.html)

    Using hype utilities to pixellate an image.

[examples]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/external_library/java/hype
[Hype processing framework]:https://www.hypeframework.org/
[color]: {{ site.url }}/alternatives/
[polyglot]:https://github.com/takari/polyglot-maven/
[build]:http://ruby-processing.github.io/JRubyArt/libraries/hype
