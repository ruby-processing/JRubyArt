---
layout: post
title:  "Comparison with ruby-processing"
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

|feature       |  ruby-processing  |  JRubyArt               |
|----------    |---------------    |-----------              |
|binary        |rp5                |k9                       |
|run opts      |run, watch, live   |-r, -w, -l               |
|jruby version |1.7.27             |9.2.6.0+                 |
|App Export    |Yes                |Not Yet                  |
|Live mode     |Yes                |Yes                      |
|Watch mode    |Yes                |Yes                      |
|jruby-complete|`--nojruby` flag   |see alternative          |
|config        |`~/.rp5rc`         |`~/.jruby_art/config.yml`|
|alternative   |JRUBY: false       |JRUBY: false             |
|global        |$app               |Processing.app           |
|settings      |no                 |see below                |

The `settings` method was introduced to vanilla processing since processing-3.0. However this is hidden for users of the [processing ide][settings] but required by Eclipse users. The `settings` method is where `size` belongs or `full_screen`, also you should set `smooth` and `pixel_density` here. Retina users can make use of their hi-dpi display by setting `pixel_density(2)`, NB: size should be first line of `settings`, and if used `pixel_density(2)` should be next.

In JRubyArt use the `data_path` wrapper to return the absolute path for the `data` folder [see here][here] (this means `--nojruby` flag is obsolete since even shader sketches should now run with an installed jruby). Set `JRUBY: false` in config.yml to use jruby-complete instead of an installed jruby (crucial if you haven't installed jruby on your system).


[settings]:https://processing.org/reference/settings_.html
[here]:{{site.github.url}}/data_path/
