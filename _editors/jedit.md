---
layout: post
title:  "JEdit"
permalink: /editors/jedit/
keywords: editor, ide, ruby, jruby_art, jedit
---

Alternatively install my jEdit [k9.xml][commando] commando file. To `run`/`watch` JRubyArt sketches all from the jEdit ide/editor (Windows users should be most interested in this). Can be used as `pry` editor (but like the processing ide, it looks bit out of date, so you may prefer the atom editor), or for simplicity just use vim.

![jEdit]({{ site.github.url }}/assets/jedit.png)

### Installation

Install [jEdit][jedit] and the [console][console] and [xml][xml] plugins at a minimum, the latter is useful to edit the commando and mode files. Use the plugin manager to install the plugins, and to find other plugins you might like to have (unfortunately the ruby plugin is a bit out of date, but otherwise excellent).

Either clone this repro or use a zipped file, copy the files in the `.jedit` folder to wherever your `.jedit` folder is typically `~/.jedit` and edit them suit your system see below for JRubyArt for an example.

### The macro file k9.bsh

This file lives in `~/.jedit/macros/` folder use this so you you can `run`, `watch` from the `macros` menu

{% highlight java %}

// k9.bsh
// A jedit bean shell macro, to load environment, and call
// k9 commando menu
//
// You must edit GEM_HOME/GEM_PATH to match your system
// if you use setenv (but usually you wont need to set it)
// example below for ArchLinux with user 'tux'
// Using Oracle jdk installed under /opt
//

// setenv("JAVA_HOME", "/opt/jdk1.8.0_102");
// setenv("JRUBY_HOME", "/opt/jruby");
// setenv("GEM_HOME", "/home/tux/.gem/ruby/2.3.0");
// setenv("GEM_PATH", "/home/tux/.gem/ruby/2.3.0");
// setenv("PATH", "/usr/bin");
new console.commando.CommandoDialog(view,"commando.k9");

{% endhighlight %}

### The commando file k9.xml for JRubyArt-1.2.0+

This file lives in `~/.jedit/console/commando/` you should tune this to match your OS setup

{% highlight xml %}
<?xml version="1.0"?>
<!DOCTYPE COMMANDO SYSTEM "commando.dtd"><!-- Monkstone, 2016-July-13 for JRubyArt-1.2.0+ -->
<COMMANDO>
  <UI>
    <CAPTION LABEL="Run">
      <FILE_ENTRY LABEL="ruby file" VARNAME="file" EVAL="buffer.getName()"/>
    </CAPTION>
    <CAPTION LABEL="Path to k9">
      <ENTRY LABEL="path" VARNAME="k9path" DEFAULT=""/>
    </CAPTION>
    <CAPTION LABEL="Choose Run/Watch/Version">
      <CHOICE LABEL="Select" VARNAME="type" DEFAULT="run">
        <OPTION LABEL="run" VALUE="-r"/>
        <OPTION LABEL="watch" VALUE="-w"/>
        <OPTION LABEL="check" VALUE="--check"/>
        <OPTION LABEL="version" VALUE="--version"/>
      </CHOICE>
    </CAPTION>
  </UI>

  <COMMANDS>
    <COMMAND SHELL="System" CONFIRM="FALSE">
<!-- cd to working dir -->

	  buf = new StringBuilder("cd ");
	  buf.append(MiscUtilities.getParentOfPath(buffer.getPath()));
	  buf.toString();

</COMMAND>
    <COMMAND SHELL="System" CONFIRM="FALSE">

	  buf = new StringBuilder(k9path);
	  buf.append("k9 ");
	  buf.append(type);
	  switch(type){
	  case "-r":
	  case "-w":
	      buf.append(" ");
	      buf.append(file);
	      break;
	  case "-?":
 	      break;
	  }
	  buf.toString();

</COMMAND>
  </COMMANDS>
</COMMANDO>
{% endhighlight %}

### keyboard shortcuts

The macro menu is accessible with `Alt c`.  However you should create a direct shortcut to the macro say `Alt k` see how in `Utilities/Global Options` menu.

[jedit]:http://www.jedit.org/index.php
[commando]:https://github.com/monkstone/jedit4processing/blob/master/.jedit/console/commando/k9.xml
[console]:http://plugins.jedit.org/plugins/?Console
[xml]:http://plugins.jedit.org/plugindoc/XML/
