---
layout: post
title:  "Implementing java interfaces"
keywords: using, module
---
Java interfaces are mapped to modules in JRuby. This means that you can also reopen the corresponding module and add further methods on the JRuby side. JRuby classes can now implement more than one Java interface. Since Java interfaces are mapped to modules in JRuby, you implement them not by subclassing, but by mixing them in.

```ruby
class SomeJRubyObject
  include java.lang.Runnable
  include java.lang.Comparable
end
```

Another example is implementing an interface from  the `jbox2d` library, here is the java interface (_sans comments_):-

```java
package org.jbox2d.callbacks;

import org.jbox2d.collision.Manifold;
import org.jbox2d.dynamics.contacts.Contact;

public interface ContactListener {
	public void beginContact(Contact contact);
	public void endContact(Contact contact);
	public void preSolve(Contact contact, Manifold oldManifold);
	public void postSolve(Contact contact, ContactImpulse impulse);
}
```

And this is how we implement that interface in JRubyArt see [full example here][collision_listening], note empty methods are just fine.

```ruby
# A custom listener allows us to get the physics engine to
# to call our code, on say contact (collisions)
class CustomListener
  include ContactListener

  def begin_contact(cp)
    # Get both fixtures
    f1 = cp.getFixtureA
    f2 = cp.getFixtureB
    # Get both bodies
    b1 = f1.getBody
    b2 = f2.getBody
    # Get our objects that reference these bodies
    o1 = b1.getUserData
    o2 = b2.getUserData
    return unless [o1, o2].all? { |obj| obj.respond_to?(:change) }
    o1.change
    o2.change
  end

  def end_contact(_cp)
  end

  def pre_solve(_cp, _m)
  end

  def post_solve(_cp, _ci)
  end
end
```

[collision_listening]:https://github.com/ruby-processing/JRubyArt-examples/blob/master/external_library/gem/pbox2d/collision_listening.rb
