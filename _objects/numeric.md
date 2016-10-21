---
layout: post
title:  "Numeric Objects"
keywords: numeric, float, fixnum, rational
---

In a sense this section is only required because of `OO` languages that support the concept of a `primitive` type (Java, C++) in languages like ruby and smalltalk and even python everything is an object. So you should prefer ruby `x.abs` to vanilla processings `abs(x)` etc.

### Fixnum ###

Holds Integer values that can be represented in a native machine word (minus 1 bit). If any operation on a [Fixnum][fixnum] exceeds this range, the value is automatically converted to a Bignum.

### Float ###

[Float objects][float] represent inexact real numbers using the native architecture's double-precision floating point representation.  Floating point has a different arithmetic and is an inexact number.

#### constants ###
* __DIG__ The minimum number of significant decimal digits in a double-precision floating point. Usually defaults to 15.
* __EPSILON__ The difference between 1 and the smallest double-precision floating point number.  Usually defaults to 2.2204460492503131e-16.

### Bignum ###

[Bignum objects][bignum] hold integers outside the range of Fixnum. Bignum objects are created automatically when integer calculations would otherwise overflow a Fixnum. When a calculation involving Bignum objects returns a result that will fit in a Fixnum, the result is automatically converted.

### Rational ###

A rational number can be represented as a paired integer number; `a/b` (b>0). Where `a` is numerator and `b` is denominator. Integer `a` equals rational `a/1` mathematically.  A [rational object][rational] is an exact number, which helps you to write program without any rounding errors.

### JRubyArt ###

We have re-opened the `Numeric` class to implement `radians` and `degree` methods, which means that instead of using `radians(x)` a processing method, you should use `x.radians` in JRubyArt. But this should not be so necessary now we have `DegLut.cos` and `DegLut.sin` methods.

[float]:https://ruby-doc.org/core-2.2.0/Float.html
[fixnum]:https://ruby-doc.org/core-2.2.0/Fixnum.html
[bignum]:https://ruby-doc.org/core-2.2.0/Bignum.html
[rational]:https://ruby-doc.org/core-2.2.0/Rational.html
