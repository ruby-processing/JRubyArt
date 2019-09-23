---
layout: post
title: "Installing Contributed Java Libraries for JRubyArt"
date: 2019-092305 06:00:00
keywords: JRubyArt, wget, java, libraries, contributed
permalink: contributed
---
### Listing Libraries and their urls ###

```bash
wget http://download.processing.org/contribs/contribs.txt
```

NB `toxiclibs`, `pbox2d`, `joonsrenderer`, `wordcram`  and `geomerative libraries` are available as rubygems, further the libraries in the contributed list only contains libraries curated (_filtered_) by Prisoner John, there are many more that are available out there eg Joshua Davis `hype`.

An example library listing in contribs.txt:-

<pre>
library
minRevision=228
name=gicentreUtils
maxRevision=0
sentence=Assists creation of data visualization sketches.
url=http://www.gicentre.org/utils/
prettyVersion=3.4.0
paragraph=Includes color utilities, statistical graphics, morphing classes, spatial utilities and map projections, force-directed layouts and text input/output. Together these make the task of creating data visualization sketches much faster by providing code for commonly repeated tasks such as zooming in and out of a sketch, setting up color tables etc. For documentation and examples, see the [gicentreUtils pages](http://www.gicentre.org/utils/).
version=14
authors=[Jo Wood](http://gicentre.org/) and [Aidan Slingsby](http://gicentre.org/)
download=http://staff.city.ac.uk/~jwo/giCentre/utils/gicentreUtils.zip
type=library
id=004
</pre>

### Installing a library ###

Install libraries to your `~/.JRubyArt/libraries` folder.  NB: this created for you when you install the `video` or `sound` libraries.

```bash
jruby_art -i Sound
jruby_art -i Video
```

It can make sense to convert the library names and jars from `camelcase` to `snakecase`, (_ie when library creators have messed up_) you just need to be consistent, see below

```bash
cd ~/.jruby_art/libraries
wget http://staff.city.ac.uk/~jwo/giCentre/utils/gicentreUtils.zip
unzip gicentreUtils.zip # NB: British English spelling of centre
mv gicentreUtils gicenter_utils # Use snake case, and convert spelling
cd gicenter_utils/library
mv gicentreUtils.jar gicenter_utils.jar
```
Here is an example sketch translated to JRubyArt, main differences are how we load libraries and access package namespace in JRubyArt. Also note the use of the data_path wrapper to access sketch data folder. Another twist is the need to cast array of ruby Numbers to java float.

```ruby
# Sketch to demonstrate the use of the BarChart class to draw simple bar charts.
# Version 1.3, 6th February, 2016.
# Author Jo Wood, giCentre.
load_library :gicenter_utils
include_package 'org.gicentre.utils.stat' # British spelling

def settings
  size(800, 300)
  smooth
end

def setup # a static sketch no need for draw loop
  sketch_title 'Bar Chart Sketch'
  title_font = load_font(data_path('Helvetica-22.vlw'))
  small_font = load_font(data_path('Helvetica-12.vlw'))
  text_font(small_font)
  bar_chart = BarChart.new(self)
  data_float = [
    2_462, 2_801, 3_280, 3_983, 4_490, 4_894, 5_642, 6_322, 6_489, 6_401,
    7_657, 9_649, 9_767, 12_167, 15_154, 18_200, 23_124, 28_645, 39_471
  ]
  bar_chart.setData(data_float.to_java(:float))
  data_label = %w(1830 1840 1850 1860 1870 1880 1890 1900 1910 1920 1930 1940 1950 1960 1970 1980 1990 2000 2010)
  bar_chart.setBarLabels(data_label)
  bar_chart.setBarColour(color(200, 80, 80, 100))
  bar_chart.setBarGap(2)
  bar_chart.setValueFormat('$###,###')
  bar_chart.showValueAxis(true)
  bar_chart.showCategoryAxis(true)
  background(255)
  bar_chart.draw(10, 10, width - 20, height - 20)
  fill(120)
  text_font(title_font)
  text('Income per person, United Kingdom', 70, 30)
  text_height = text_ascent # of title font
  text_font(small_font)
  text('Gross domestic product measured in inflation-corrected $US', 70, 30 + text_height)
end
```
