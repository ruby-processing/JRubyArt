---
layout: post
title:  "Custom"
keywords: using, module
---
Ruby users will be familiar with the use of modules, but may not be aware that they can be of particular use in JRubyArt (and jruby generally)

### Namespace to wrap java packages ###

Use `include_package` within a Ruby Module to import a Java Package's classes on const_missing

Use `include_package 'package_name'` in a Ruby Module to support namespaced access to the Java classes in the package. This is similar to Java's `package xxx.yyy.zzz;` format. It is also legal to use `java_import 'package_name'`, that is similar to `import package_name.*`.

__Example__: using include_package in a module
```ruby
module MyApp
 include_package 'org.apache.logging.log4j'
 # now any class from "org.apache.logging.log4j" will be available within
 # this module, ex if "org.apache.logging.log4j.LogManager" exists ...
 Logger = LogManager.getLogger('MyApp')
end
```

__Example__: create a Ruby Module called JavaLangDemo that includes the classes in the Java package java.lang.
```ruby
module JavaLangDemo
  include_package 'java.lang'
  # alternately, use the #import method
  # java_import 'java.lang'
end
```

Now you can prefix the desired Java Class name with `JavaLangDemo::` to access the included class

__Example__: Simpler form available in a JRubyArt sketch

But we have made this even easier for you because since we wrap the processing sketch in a `Processing` module so you are able to just use `include_package` in your JRubyArt sketches. See below
example where include several `ddf.minim` packages in a sketch:-

```ruby
load_library :minim
include_package 'ddf.minim'
include_package 'ddf.minim.ugens'
# the effects package is needed because the filters are there for now.
include_package 'ddf.minim.effects'
```

However you may still want to use full method above to create a namespace (which you may need to prefix with `Processing::` if accessed outside the `Processing` module)

__Example__: multiple (nested) packages in a module
```ruby
module Hype
  include_package 'hype.extended.colorist'
  include_package 'hype.extended.layout'
  # a sometimes better alternative, is to use the java_import for specific classes
  # java_import 'hype.extended.colorist.HColorPool'
  # java_import 'hype.extended.layout.HGridLayout'
end
```
Now you can prefix the desired Java Class name with `Hype::` to access the included classes `Hype::HColorPool` and `Hype::HGridLayout`.
