## JRubyArt
[![Gem Version](https://badge.fury.io/rb/jruby_art.svg)](http://badge.fury.io/rb/jruby_art)

Is an alternative implementation of [ruby-processing][] that provides a ruby-wrapper for the java version of [processing][]. It is currently at the pre-release stage, but is ready for testing, and available from rubygems.org.
Core processing jars are included, so it does not require a vanilla processing install... yous should perhaps consider making a contribution to the [processing foundation][].

### Requirements

Java runtime 7+, and ruby (can be MRI ruby), curl (to download jruby-complete and examples, although there is a  workaround). NB: it is not necessary to install vanilla [processing][] with this implementation, core jars are included in the gem.

### Getting Started

```bash
gem install jruby-art --pre
k9 setup install # uses curl to to download jruby-complete and examples
cd examples/contributed
k9 run clock.rb # if you've got jruby on your machine `jruby clock.rb` also works
```

### Creating your own
```bash
k9 create my_sketch 200 200
vim my_sketch.rb # other editors are available
```
Output:
```ruby
require 'jruby_art'

class MySketch < Processing::App
  def setup
    size 200, 200
  end

  def draw

  end
end

MySketch.new(title: 'My Sketch')
```
The above is an example of class wrapped sketch (that can be run using `jruby my_sketch.rb` or `k9 run my_sketch.rb`), bare sketches also work. See [examples/bare_sketches][]
```ruby
def setup
  size 200, 200
end

def draw

end
```
However such sketches must be run with `k9 run sketch.rb`, however you can do 'k9 wrap sketch.rb` which converts bare sketches to a class wrapped form.

###Ruby Versions

jruby-1.7.19 (when sketches run with jruby command)

jruby-9.0.0.0.pre1 also seems to work (the next pre-release will target jruby-9.0.0.0-pre2)

or

ruby-2.1.2+ (when sketches are run using k9 command, ie using jruby-complete)

### Using netbeans as an ide for JRubyArt

See [netbeans][]

___

[Contributing][]

[License][]

[Acknowledgements][]

[Examples][]

[CHANGELOG][]

[Building latest gem](https://github.com/ruby-processing/JRubyArt/wiki/Building-latest-gem/)
[Acknowledgements]:ACKNOWLEDGEMENTS.md
[CHANGELOG]:CHANGELOG.md
[Contributing]:CONTRIBUTING.md
[Examples]:https://github.com/ruby-processing/JRubyArt-examples
[examples/bare_sketches]:https://github.com/ruby-processing/JRubyArt-examples/tree/master/bare_sketches
[License]:LICENSE.md
[processing]:https://github.com/processing/processing
[ruby-processing]:https://github.com/jashkenas/ruby-processing
[netbeans]:http://learning-ruby-processing.blogspot.co.uk/2014/10/alternative-ruby-processing-implentation.html
[processing-2.2.1]:https://processing.org/download/
[processing-core]:https://github.com/ruby-processing/processing-core/blob/master/README.md
[processing foundation]:https://processing.org/download/
