---
layout: post
title:  "map"
keywords: blocks, map
---
If you want to use the processing `map` method see [methods map1d][map1d]

### map and map! in ruby ###

__Example__: creating an array from range using map and a block

```ruby
(0..8).map { rand(0..8) }
```

__Example__: creating a random array of Cube objects from range using map and a block

```ruby
@cubies = (0..CUBE_NO).map { Cube.new(rand(5..15)) }
```

__Example__: creating an array `Vec3D` from an array of numbers using map and a block

```ruby
@arr = [0, 0.5, 1.5, 3.5, 7.5, 15].map { |x| Vec3D.new(x * -1, x, x * -1) }
```

#### Subtleties ####

In ruby there are often shortcuts here is one example in longform:-
```ruby
class Foo
  def method_name
    puts "method called for #{object_id}"
  end
end

[Foo.new, Foo.new].map do |element|
  element.method_name
end

# => method called for 70339841711300
# => method called for 70339841711280
```

But here the shortform version would be preferred:-

```ruby
[Foo.new, Foo.new].map(&:method_name)
```
Which means call the method `method_name` on each item of the list.

[map1d]:{{site.github.url}}/methods/map1d/
