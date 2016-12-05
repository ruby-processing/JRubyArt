---
layout: post
title:  "Comparison with ruby-processing"
date:   2015-09-28 06:24:13
categories: jruby_art update
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

|feature       |  ruby-processing  |  JRubyArt       |
|----------    |---------------    |-----------      |
|binary        |rp5                |k9               |
|java          |jdk-7              |jdk-8            |
|version       |processing-2.2.1   |processing-3.2.1+|
|ruby          |1.9.3              |2.2+             |
|ArcBall       |library            |built-in         |
|Vec2D         |library            |built-in         |
|Vec3D         |library            |built-in         |
|DegLut        |library            |built-in         |
|FX2D          |No                 |Yes              |
|App Export    |Yes                |No               |
|Live mode     |Yes                |Yes              |
|Watch mode    |Yes                |Yes              |
|`--nojruby`   |see below          |JRUBY: false     |
|settings      |no                 |see below        |


For ruby-processing the `--nojruby` flag (or running with jruby-complete) is required to run a number of sketches eg `shader` and `load_image`. In JRubyArt use the `data_path` wrapper to return the absolute path for the `data` folder [see here][here]. Set `JRUBY: false` in config.yml to use jruby-complete instead of an installed jruby (crucial if you haven't installed jruby on your system).

Introduced for processing-3.0 is the `settings` method, but this is hidden for users of the [processing ide][settings]. This is where `size` belongs or `full_screen`, also you should set `smooth` and `pixel_density` here. Retina users can make use of their hi-dpi display by setting `pixel_density(2)`, NB: size should be first line of `settings`, and if used `pixel_density(2)` should be next.

[settings]:https://processing.org/reference/settings_.html
[here]:{{site.github.url}}/data_path/
