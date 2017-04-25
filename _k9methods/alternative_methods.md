---
layout: post
title:  "alternative ruby methods"
permalink: /alternatives/
---
<style>
table{
    border-collapse: collapse;
    border-spacing: 0;
    border:2px solid #0000FF;
}

th{
    border:2px solid #0000FF;
}
</style>
You can use most [processing methods][processing] in propane, but where possible you should prefer these ruby alternatives (you should also prefer Vec2D and Vec3D to PVector).
Here is a list of ruby alternatives to some 'processing' convenience methods; which with the exception of `color`, `map1d`, `p5map`, `degrees` and `radians` are just regular ruby methods.

|function       |processing            |JRubyArt           |
|----------     |-------------       |------               |
|camera         |`camera(args)`      |`kamera(hash_args)`  |
|color string   |`color(#cc6600)`      |`color('#cc6600')` |
|date/time      |                      |`t = Time.now`       |
|               |`day`                   |`t.day`              |
|               |`hour`                  |`t.hour`             |
|               |`minute`                |`t.minute`           |
|               |`second`                |`t.second`           |
|               |`year`                  |`t.year`             |
|custom math    |`map(x, b0, eo, b1, e1)`|`map1d(x, (b0..e0), (b1..e1))`|
|               |`map(x, b0, eo, b1, e1)`|`p5map(x, b0, e0, b1, e1)`|
|               |`min(array)`            |`array.min`       |
|               |`max(array)`            |`array.max`       |
|conversion     |`degrees(theta)`        |`theta.degrees`    |
|conversion     |`radians(theta)`        |`theta.radians`    |
|conversion     |`hex(string)`           |`string.hex`       |
|conversion     |`unhex(string)`         |`string.to_i(base=16)`|
|conversion     |`binary(c)`             |`c.to_s(2)`        |
|conversion     |`unbinary(string)`      |`string.to_i(base=2)`|
|math           |`abs(x)`                |`x.abs`            |
|math           |`round(x)`              |`x.round`          |
|math           |`ceil(x)`               |`x.ceil`           |
|math           |`random(x)`             |`rand(x)`          |
|math           |`random(a, b)`          |`rand(a..b)`       |
|math power     |`pow(a, b)`             |`a**b`             |
|square         |`sq(x)`                 |`x * x`            |
|print          |`println(x)`            |`puts x`           |
|format         |`trim(string)`          |`string.strip`     |
|format         |`nf(float_value, 0, 2)` |`format('%.2f', float_value)`|
|format         |`nf(num, digit)`        |`num.to_s.rjust(digit, '0')`|
|format         |`nf(nf(num, left, right)`|`see below`     |

`num.to_s.rjust(left, '0').ljust(left + right, '0')`

For examples of using time in sketches see [learning JRubyArt blog][time], [timestamp][timestamp] and this [clock sketch][clock]. We actually use the ruby Enumerable methods `max` and `min` methods to make `max(*array)` and `min(*methods)` available in JRubyArt, so you could use the processing form providing you splat the array, but it is simpler to use the ruby method directly further you have the option with ruby of changing the [comparator via a block][comparator].

For example of `kamera` usage see [kamera][kamera]. To use `selectInput` see link to `File Chooser` in page header.

NB: if you have any trouble with `save` or `save_frame` then use the option of providing an absolute path.  You can easily do this using the `data_path` wrapper that does it for you see [data_path method][data_path].

[time]:https://monkstone.github.io/time
[timestamp]:https://monkstone.github.io/timestamp/
[clock]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/fastmath/clock.rb
[kamera]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/camera/kmove_eye.rb
[comparator]:http://ruby-doc.org/core-2.4.0/Enumerable.html#method-i-max
[processing]:https://processing.org/reference/
[data_path]:{{site.github.url}}/data_path/
