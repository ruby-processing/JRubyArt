---
layout: post
title:  "Processing"
keywords: pde, java, processing
---
How `pde` sketches get pre-processed to java (before compiling)

sketch_161005a.pde (auto-named sketch in the processing ide)

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

This is what the java code looks like, __note__ all those `imports`, the `class wrapper`, that `MyClass` is a java inner class. Also note `size` has been moved to settings.

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

[FileChooser]:{{ site.github.url }}/classes/chooser
[callback]:https://processing.org/reference/selectInput_.html
