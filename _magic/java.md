---
layout: post
title:  "Java"
keywords: ruby, java, jruby
---
Here will go stuff about java [inner][inner] classes and [reflection][reflection]. See how the pre-processing of the [pde][pde] sketches to valid java creates [java inner classes][pde]. This is all magic stuff that gets hidden from the average user.
### Inner Classes ###

_Stolen from http://www.programmerinterview.com/_

What’s so special about inner classes?

So, what exactly is special about inner classes? Well, the main thing that you must remember about inner classes is that an instance of an inner class has access to all of the members of the outer class, even those that are marked “private”. So, when an instance of the inner class is created, there are no issues with having the inner class access the instance variables of the outer class.

### Reflection ###

_Stolen from stack exchange_

* Reflection is much slower than just calling methods by their name, because it has to inspect the metadata in the bytecode instead of just using precompiled addresses and constants.
* Reflection is also more powerful: you can retrieve the definition of a protected or final member, remove the protection and manipulate it as if it had been declared mutable!
* Obviously this subverts many of the guarantees the language normally makes for your programs and that can be extremely dangerous.
And this pretty much explains when you would use it. Ordinarily, don't. If you want to call a method, just call it. If you want to mutate a member, just declare it mutable instead of going behind the compiler's back.

One useful real-world use of reflection is when writing a framework that has to interoperate with user-defined classes, where the framework author doesn't know what the members (or even the classes) will be. Reflection allows them to deal with any class without knowing it in advance. For instance, I don't think it would be possible to write a complex aspect-oriented library without reflection.

[reflection]:https://docs.oracle.com/javase/tutorial/reflect/
[inner]:https://docs.oracle.com/javase/tutorial/java/javaOO/innerclasses.html
[pde]:{{site.github.url}}/magic/processing.html
