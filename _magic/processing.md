---
layout: post
title:  "Processing"
keywords: pde, java, processing
---
## __pde__ sketches get pre-processed to __java__ ##
------
Part of the attraction of processing is that it hides a lot of java boilerplate stuff from the user.  In vanilla processing all sketches get [pre-processed][casey] to java prior to compilation:-

So sketch_161005a.pde (an auto-named sketch in the processing ide), gets transformed as follows.

```java
MyClass var;

void setup(){
  size(200, 200);
  var = new MyClass(23);
}

void draw(){
  background(255, 0, 0);
  fill(0, 0, 200);
  ellipse(100, 100, 90, 120);

}

class MyClass{
  float var;
  MyClass(float var){
  this.var = var;
  }
}
```

See the generated java code below, __note__ all those `imports`, the `class wrapper`, and that `MyClass` becomes a java [inner class][inner]. Also __note__ that `size` has moved to settings (_the processing guys decided not make this change from processing-2.0 to processing-3.0 explicit, in JRubyArt and propane we do expect size to be in settings_).

```java
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class sketch_161005a extends PApplet {

MyClass var;

public void setup(){

  var = new MyClass(23);
}

public void draw(){
  background(255, 0, 0);
  fill(0, 0, 200);
  ellipse(100, 100, 90, 120);

}

class MyClass{
  float var;
  MyClass(float var){
  this.var = var;
  }
}
  public void settings() {  size(200, 200); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sketch_161005a" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
```

## java reflection gets used a lot in processing ##
------

It is an unfortunate truth that [java reflection methods][reflection] are popular with both processing developers and some developers of supporting libraries. It is unfortunate because we have to go through hoops to use these methods in JRubyArt (and ruby-processing). The `captureEvent` and `videoEvent` are examples of reflection methods from the processing video developers. But we have made these readily available to JRubyArt users as a [simple library][library] load `load_library :video_event`. This is what you would do (if we had not created the `video_event` library):-

- create a java class `VideoInterface`
- compile the java class (including classpath)
- create a jar (and place it in the same folder as your sketch)
- modify the sketch to both `require` the `jar` and to `include` the interface.

### VideoInterface.java ###

```java
package monkstone.videoevent;
import processing.video.Movie;
import processing.video.Capture;
/**
 * This interface makes it easier/possible to use the reflection methods
 * from Movie and Capture classes in Processing::App in JRubyArt
 * @author Martin Prout
 */
public interface VideoInterface {
    /**
     * Used to implement reflection method in PApplet
     * @see processing.video.Movie
     * @param movie Movie
     */
    public void movieEvent(Movie movie);
    /**
     * Used to implement reflection method in PApplet
     * @see processing.video.Capture
     * @param capture Capture
     */
    public void captureEvent(Capture capture);    
}
```

To match packaging the java file needs to be nested in `monkstone/videoevent` folders (it is unwise not to have a package) and compile and jar as follows, requires jdk11+.

```bash
# NB: classpath needs to be a fully qualified path to jars (not as below)
javac -cp video.jar:core.jar monkstone/videoevent/VideoInterface.java

jar -cvf video_event.jar monkstone
```

See below a sketch which using this VideoEvent interface, see the version using the JRubyArt provided `:video_event` library [here][bw]

### black_white_capture.rb ###

```ruby
require_relative 'video_event'
load_libraries :video
include_package 'processing.video'

include Java::MonkstoneVideoevent::VideoInterface

attr_reader :cam, :my_shader

def setup
  sketch_title 'Black & White Capture'
  @my_shader = load_shader('bwfrag.glsl')
  start_capture(width, height)
end

def start_capture(w, h)
  @cam = Capture.new(self, w, h)
  cam.start
end

def draw
  image(cam, 0, 0)
  return if mouse_pressed?
  filter(my_shader)
end

# using snake case to match java reflection method
def captureEvent(c)
  c.read
end

def settings
  size(960, 544, P2D)
end
```

Now where this knowledge becomes really useful, is when you want to use another library, say the vanilla processing carnivore library whose `packetEvent` method also depends on java relection. Here is a suitable CarnivoreListener class.

### CarnivoreListener.java ###

```java

package monkstone;

/*
* Best to use a package to avoid namespace clashes, create your own
*/
public interface CarnivoreListener {
  /*
  * @param packet the CarnivorePacket, a reflection method
  */
  public void packetEvent(org.rsg.carnivore.CarnivorePacket packet);  
}
```

Which we compile as before

```bash
# NB: classpath needs to be a fully qualified path to jar (not as below)
javac -cp carnivore.jar monkstone/CarnivoreListener.java

jar -cvf carnivore_listener.jar monkstone
```

Here is an example sketch:-

### carnivore1.rb ###

```ruby
# A Simple Carnivore Client -- print packets in Processing console
#
# Note: requires Carnivore Library for Processing (https://r-s-g.org/carnivore)
#
# + Windows:  first install winpcap (https://winpcap.org)
# + Mac:      first open a Terminal and execute this commmand: sudo chmod 777 /dev/bpf*
#             you need to do this each time you reboot Mac
# + Linux:    run with difficulty (run with sudo rights arghh!!!) also install libpcap

load_library :carnivore
include_package 'org.rsg.carnivore'
java_import 'org.rsg.lib.Log'
require_relative 'carnivore_listener'

include Java::Monkstone::CarnivoreListener

attr_reader :c

def settings
  size(600, 400)
end

def setup
  sketch_title 'Carnivore Example'
  background(255)  
  @c = CarnivoreP5.new(self)
  Log.setDebug(true) # comment out for quiet mode
  # c.setVolumeLimit(4) #limit the output volume (optional)
  # c.setShouldSkipUDP(true) #tcp packets only (optional)
end

def draw
end

# Called each time a new packet arrives
def packetEvent(p)
  puts(format('(%s packet) %s > %s', p.strTransportProtocol, p.senderSocket, p.receiverSocket))
  # puts(format('Payload: %s', p.ascii))
  # puts("---------------------------\n")
end
```


Another example of reflection usage the vanilla processing `selectInput` utility, that enable use of the native file chooser:-

### Native File Chooser ###

What a native file chooser sketch looks like in java, the `selectInput` [callback][callback] relies on java reflection under the hood. We have to explicity provide such a signature to use this feature in JRubyArt hence [FileChooser][FileChooser] library.

```java
public class chooser extends PApplet {

public void setup() {
  selectInput("Select a file to process:", "fileSelected");
}

public void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "chooser" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
```

Read more about java [reflection here][reflection].

[casey]:https://github.com/processing/processing/wiki/FAQ
[inner]:https://docs.oracle.com/javase/tutorial/java/javaOO/innerclasses.html
[FileChooser]:{{ site.github.url }}/classes/chooser
[callback]:https://processing.org/reference/selectInput_.html
[library]:{{ site.github.url }}/libraries/video_event.html
[reflection]:https://docs.oracle.com/javase/tutorial/reflect/
[bw]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/library/video/capture/black_white_capture.rb
