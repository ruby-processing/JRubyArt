---
layout: post
title:  "max and min"
keywords: blocks, max, min
---
If you want to use the processing `max`, `min` method see [methods max][max]

### max and min with block ###

Both `max` and `min` are methods from the Enumerable module, and can be used directly with objects that implement Comparable. However you are also able to provide your own comparable block, to provide/change order of Comparison. See below where the default Comparable for string is alphabetical, but in the second instance we compare (order) by length of string.

```ruby
a = %w(albatross dog horse)
a.max                                   #=> "horse"
a.max { |a, b| a.length <=> b.length }  #=> "albatross"
```

But say our custom `object` does not implement Comparable, but its `value` method does (eg float) then we can just define the Comparable as below.

```ruby
arr = [a, b, c, x, y, z] # where a, b, c, x, y, z are custom objects with method :value
arr.min { |a, b| a.value <=> b.value }  #=> one of a, b, c, x, y, z that has minimum value
```

[max]:{{site.github.url}}/methods/alternative_methods/
