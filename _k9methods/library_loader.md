---
layout: post
title:  "load_library"
keywords: ruby, java, jruby, library, load_library, native
permalink: /load_library
---
The purpose of the `load_library` (synonym `load_libraries`) method is to provide a convenient way to load the different kinds of ruby [libraries][libraries], and in the case of java libraries that use a native library, load the relevant classpath.  It does this by a mixture of pattern matching and honest magic so that you don't need to worry about adding the native libraries to classpath to the java runtime, and lots of other incomprehensible stuff. When it works it is fabulous (which is most of the time on Linux64 bit and MacOSX). See examples under [libraries][libraries].

### Cautionary Notes ###

Simply loading in the code for a library via `load_library` may not be enough to actually import the library's classes into your namespace. For some libraries, such as __Minim__, you'll want to import the package as well (as you would in Java):

```ruby
load_library 'minim'
java_import 'ddf.minim'
java_import 'ddf.minim.analysis'
include_package 'ddf' # can also be use to "import the ddf package"
```

 Some libraries use Java's reflective capacities to try and invoke methods on your sketch. If the methods that they're looking for happen to be defined in Ruby alone, Java won't be able to find them. Better support for this sort of thing may be forthcoming in a future JRuby releases, but for now you'll either need to patch the library to stop using [reflection][reflection] on the sketch, or insert a thin Java interface. For example, the [Carnivore][carnivore] library uses reflection and tries to find a `packetEvent()` method on the sketch. An appropriate fix is to create, compile and jar-up a java interface, and then include it into your sketch. See also how we implement a native [FileChooser][magic] (_reflection can be a pain, and unfortunately those processing guys seem to be dead keen on it_).

```java
public interface PacketListener {
 public void packetEvent(org.rsg.carnivore.CarnivorePacket packet);  
}
```

Compile it, jar it up.

<pre>
javac -cp path/to/carnivore.jar PacketListener.java
jar cvf packet_listener.jar PacketListener.java
</pre>

And then include it in your sketch...

```ruby
require 'packet_listener'
include Java::PacketListener

def packetEvent(packet)
  # code goes here...
end
```

[libraries]:{{ site.github.url }}/libraries.html
[carnivore]:http://r-s-g.org/carnivore/installation.html
[magic]:{{ site.github.url }}/magic/processing
[reflection]:https://docs.oracle.com/javase/tutorial/reflect/
