---
layout: post
title:  "yield"
keywords: blocks, optional
---
__Example__: drawolver.rb
You can write some incredibly sophisticated code in ruby if you embrace blocks, take for example [drawolver.rb][module_two] where we extend an instance of Array to produce a differently shaped iterator using `one_of_each`, kudos to Florian Jenett who created the original version:-

```ruby
module ExtendedArray
  # send one item from each array, expects array to be 2D:
  # array [[1,2,3], [a,b,c]] sends
  # [1,a] , [2,b] , [3,c]
  def one_of_each(&block)
    i = 0
    one = self[0]
    two = self[1]
    mi = one.length > two.length ? two.length : one.length
    while i < mi do
      yield(one[i], two[i])
      i += 1
    end
  end
end
```

Here is creation of the `ExtendedArray` instance where r1 and r2 are instances of `Vec3D`

```ruby
ext_array = [r1, r2].extend ExtendedArray # extend an instance of Array
ext_array.one_of_each do |v1, v2|          
  v1.to_vertex(renderer)
  v2.to_vertex(renderer)
end
```
__Example__: LSystems
Here is a simpler example that is to produce [LSystems grammar][lsystems]

```ruby
class Grammar
  attr_reader :axiom, :rules
  def initialize(axiom, rules)
    @axiom = axiom
    @rules = rules
  end

  def expand(production, iterations, &block)
    production.each_char do |token|
      if rules.key?(token) && iterations > 0
        expand(rules[token], iterations - 1, &block)
      else
        yield token
      end
    end
  end

  def each(gen)
    expand(axiom, gen) { |token| yield token }
  end

  def generate(gen)
    [].tap do |output|
      each(gen) { |token| output << token }
    end
  end
end
```

[lsystems]:https://github.com/ruby-processing/JRubyArt-examples/tree/master/processing_app/topics/lsystems/
[module_two]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/processing_app/basics/modules/module_two.rb
