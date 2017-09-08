---
layout: post
title:  "Global Variable"
keywords: App, PApplet, $
---
A global variable in ruby a name beginning with `$`. It can be referred to from anywhere in a program. Before initialization, a global variable has the special value nil. Global variables should be used sparingly. They are dangerous because they can be written to from anywhere. Overuse of globals can make isolating bugs difficult; it also tends to indicate that the design of a program has not been carefully thought out. Whenever you do find it necessary to use a global variable, be sure to give it a descriptive name that is unlikely to be inadvertently used for something else later (calling it something like $foo as above is probably a bad idea).

Prior to JRubyArt-1.4.0 we made the initialised sketch object (formerly Applet with ruby-processing) available as `$app`, this is now replaced by the safer `Processing.app`.
