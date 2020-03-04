---
layout: post
title:  "Comparison JRubyArt-2.2 and JRubyArt-1.7"
date:   2015-09-28 06:24:13
categories: jruby_art update
---

JRubyArt is actively being developed, ruby-processing should be considered to be deprecated and is no-longer actively maintained.  The only possible justification to prefer to use ruby-processing is to be compatible with processing-2.2.1. So since January 2017 table below has been modified to address what you need to know, now that you have decided to switch from ruby-processing to JRubyArt

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

|feature       |  JRubyArt-1.7     |  JRubyArt-2.0           |
|----------    |---------------    |-----------              |
|binary        |k9                 |k9                       |
|run opts      |-r, -w, -l         |-r, -w, -l               |
|jruby version |9.2.11.0 (2.5.3)    |9.2.11.0+  (2.5.3+)       |
|jdk version   |jdk8               |jdk11+                   |
|config        |PROCESSING_ROOT    |not required             |


The `settings` method was introduced to vanilla processing since processing-3.0. However this is hidden for users of the [processing ide][settings] but required by Eclipse users. The `settings` method is where `size` belongs or `full_screen`, also you should set `smooth` and `pixel_density` here. Retina users can make use of their hi-dpi display by setting `pixel_density(2)`, NB: size should be first line of `settings`, and if used `pixel_density(2)` should be next.

In JRubyArt use the `data_path` wrapper to return the absolute path for the `data` folder [see here][here] (this means `--nojruby` flag is obsolete since even shader sketches should now run with an installed jruby). Set `JRUBY: false` in config.yml to use jruby-complete instead of an installed jruby (crucial if you haven't installed jruby on your system).

[settings]:https://processing.org/reference/settings_.html
[here]:{{site.github.url}}/data_path/
