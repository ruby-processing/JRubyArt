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

NB: if no block is given an enumerator is returned instead (see map documentation)

#### Subtleties ####

Say there is an array this class Foo (_it is usually Foo unless it is Bar or FooBar_)

```ruby
class Foo
  def method_name
    puts "method called for #{object_id}"
  end
end
```

Now we want iterate of the array calling the `method_name` on each element, we could use `map` and a block as below:-

```ruby
[Foo.new, Foo.new].map do |element|
  element.method_name
end

# => method called for 70339841711300
# => method called for 70339841711280
```

However ruby there are often shortcuts, here is one example where the shortform version would be preferred (since it is a common ruby idiom):-

```ruby
[Foo.new, Foo.new].map(&:method_name)
```
The `&` takes the operand `:method_name` and turns it into a `Proc` (unless it is already a `Proc`) and passes it as if a block had been called. The result is that two forms produce the same result.

[map1d]:{{site.github.url}}/methods/map1d/
