---
layout: post
title:  "blocks with parameters"
keywords: blocks, optional
---

Our `grid` convenience method generates `x`, `y` (you can actually call them what you like) parameters that can be read in the block eg:-

```ruby
grid(100, 100, 10, 10 ) { |x, y| code }
```

Where you are expected to provide `code`, the generated `x` and `y` values here will be the same as if you had created a 2D array (but we implement it as a single loop in `java`):-

```ruby
(0..100).step(10) do |x|
  (0..100).step(10) do |y|
    ## your code here
  end
end
```

You can check this out by replacing `code` with

```ruby
puts(format('x: %d, y: %d', x, y))
```
