## JRubyArt with jruby-complete


As with [ruby-processing][] some sketches will not run with an installed jruby.
These sketches are those that require load_image (tested) and shaders
(expected). Pro-tem (ie until I create something like k9 run sketch.rb to use
jruby-complete) you can use the following:-


```bash
java -jar jruby-complete.jar my_sketch.rb
```

Or if you are using netbeans with the jruby-plugin you can run the sketch using the built in jruby....

[ruby-processing]:https://github.com/jashkenas/ruby-processing
