package monkstone.vecmath.vec2;

/*
* Copyright (c) 2015-19 Martin Prout
*
* This library is free software; you can redistribute it and/or
* modify it under the terms of the GNU Lesser General Public
* License as published by the Free Software Foundation; either
* version 2.1 of the License, or (at your option) any later version.
*
* http://creativecommons.org/licenses/LGPL/2.1/
*
* This library is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public
* License along with this library; if not, write to the Free Software
* Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
import org.jruby.Ruby;
import org.jruby.RubyArray;
import org.jruby.RubyClass;
import org.jruby.RubyFixnum;
import org.jruby.RubyFloat;
import org.jruby.RubyObject;
import org.jruby.RubySymbol;
import org.jruby.anno.JRubyClass;
import org.jruby.anno.JRubyMethod;
import org.jruby.runtime.Arity;
import org.jruby.runtime.Block;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;
import monkstone.vecmath.JRender;

/**
 *
 * @author Martin Prout
 */
@JRubyClass(name = "Vec2D")
public class Vec2 extends RubyObject {

    static final double EPSILON = 9.999999747378752e-05; // matches processing.org EPSILON
    private static final long serialVersionUID = -2950154560223211646L;

    private double jx = 0;
    private double jy = 0;

    /**
     *
     * @param runtime ThreadContext
     */
    public static void createVec2(final Ruby runtime) {
        RubyClass vec2Cls = runtime.defineClass("Vec2D", runtime.getObject(), (Ruby runtime1, RubyClass rubyClass) -> new Vec2(runtime1, rubyClass));
        vec2Cls.defineAnnotatedMethods(Vec2.class);
    }

    public double javax() {
        return jx;
    }

    public double javay() {
        return jy;
    }

    /**
     *
     * @param context ThreadContext
     * @param klazz IRubyObject
     * @param args optional (no args jx = 0, jy = 0)
     * @return new Vec2 object (ruby)
     */
    @JRubyMethod(name = "new", meta = true, rest = true)
    public static final IRubyObject rbNew(ThreadContext context, IRubyObject klazz, IRubyObject... args) {
        Vec2 vec2 = (Vec2) ((RubyClass) klazz).allocate();
        vec2.init(context, args);
        return vec2;
    }

    /**
     *
     * @param runtime Ruby
     * @param klass RubyClass
     */
    public Vec2(Ruby runtime, RubyClass klass) {
        super(runtime, klass);
    }

    void init(ThreadContext context, IRubyObject... args) {
        if (args.length == 2) {
            jx = (args[0] instanceof RubyFloat) ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
            jy = (args[1] instanceof RubyFloat) ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
        }   // allow ruby ducktyping in constructor
        if (args.length == 1) {
            if (!(args[0].respondsTo("x"))) {
                throw context.runtime.newTypeError(args[0].getType() + " doesn't respond_to :x & :y");
            }
            jx = ((args[0].callMethod(context, "x")) instanceof RubyFloat)
                    ? ((RubyFloat) args[0].callMethod(context, "x")).getValue() : ((RubyFixnum) args[0].callMethod(context, "x")).getDoubleValue();
            jy = ((args[0].callMethod(context, "y")) instanceof RubyFloat)
                    ? ((RubyFloat) args[0].callMethod(context, "y")).getValue() : ((RubyFixnum) args[0].callMethod(context, "y")).getDoubleValue();
        }
    }

    /**
     *
     * @param context ThreadContext
     * @return x IRubyObject
     */
    @JRubyMethod(name = "x")
    public IRubyObject getX(ThreadContext context) {
        return context.runtime.newFloat(jx);
    }

    /**
     *
     * @param context ThreadContext
     * @return y IRubyObject
     */
    @JRubyMethod(name = "y")
    public IRubyObject getY(ThreadContext context) {
        return context.runtime.newFloat(jy);
    }

    /**
     *
     * @param context ThreadContext
     * @param key as symbol
     * @return value float
     */
    @JRubyMethod(name = "[]", required = 1)

    public IRubyObject aref(ThreadContext context, IRubyObject key) {
        Ruby runtime = context.runtime;
        if (key instanceof RubySymbol) {
            if (key == RubySymbol.newSymbol(runtime, "x")) {
                return runtime.newFloat(jx);
            } else if (key == RubySymbol.newSymbol(runtime, "y")) {
                return runtime.newFloat(jy);
            } else {
                throw runtime.newIndexError("invalid key");
            }
        } else {
            throw runtime.newIndexError("invalid key");
        }
    }

    /**
     * @param context ThreadContext
     * @param key as symbol
     * @param value as float
     * @return value float
     */
    @JRubyMethod(name = "[]=")
    public IRubyObject aset(ThreadContext context, IRubyObject key, IRubyObject value) {
        Ruby runtime = context.runtime;
        if (key instanceof RubySymbol) {
            if (key == RubySymbol.newSymbol(runtime, "x")) {
                jx = (value instanceof RubyFloat)
                        ? ((RubyFloat) value).getValue() : ((RubyFixnum) value).getDoubleValue();
            } else if (key == RubySymbol.newSymbol(runtime, "y")) {
                jy = (value instanceof RubyFloat)
                        ? ((RubyFloat) value).getValue() : ((RubyFixnum) value).getDoubleValue();
            }
        } else {
            throw runtime.newIndexError("invalid key");
        }
        return value;
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return x IRubyObject
     */
    @JRubyMethod(name = "x=")
    public IRubyObject setX(ThreadContext context, IRubyObject other) {
        if (other instanceof RubyFloat) {
            jx = ((RubyFloat) other).getValue();
        } else {
            jx = ((RubyFixnum) other).getDoubleValue();
        }
        return other;
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return y IRubyObject
     */
    @JRubyMethod(name = "y=")
    public IRubyObject setY(ThreadContext context, IRubyObject other) {
        if (other instanceof RubyFloat) {
            jy = ((RubyFloat) other).getValue();
        } else {
            jy = ((RubyFixnum) other).getDoubleValue();
        }
        return other;
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return distance float
     */
    @JRubyMethod(name = "dist", required = 1)
    public IRubyObject dist(ThreadContext context, IRubyObject other) {
        Vec2 b = null;
        Ruby runtime = context.runtime;
        if (other instanceof Vec2) {
            b = (Vec2) other.toJava(Vec2.class);
        } else {
            throw runtime.newTypeError("argument should be Vec2D");
        }
        double result = Math.hypot((jx - b.jx), (jy - b.jy));
        return runtime.newFloat(result);
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return cross product IRubyObject
     */
    @JRubyMethod(name = "cross", required = 1)
    public IRubyObject cross(ThreadContext context, IRubyObject other) {
        Vec2 b = null;
        Ruby runtime = context.runtime;
        if (other instanceof Vec2) {
            b = (Vec2) other.toJava(Vec2.class);
        } else {
            throw runtime.newTypeError("argument should be Vec2D");
        }
        return runtime.newFloat(jx * b.jy - jy * b.jx);
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return dot product IRubyObject
     */
    @JRubyMethod(name = "dot", required = 1)
    public IRubyObject dot(ThreadContext context, IRubyObject other) {
        Vec2 b = null;
        Ruby runtime = context.runtime;
        if (other instanceof Vec2) {
            b = (Vec2) other.toJava(Vec2.class);
        } else {
            throw runtime.newTypeError("argument should be Vec2D");
        }
        return runtime.newFloat(jx * b.jx + jy * b.jy);
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return new Vec2D object (ruby)
     */
    @JRubyMethod(name = "+", required = 1)
    public IRubyObject op_plus(ThreadContext context, IRubyObject other) {
        Vec2 b = null;
        Ruby runtime = context.runtime;
        if (other instanceof Vec2) {
            b = (Vec2) other.toJava(Vec2.class);
        } else {
            throw runtime.newTypeError("argument should be Vec2D");
        }
        return Vec2.rbNew(context, other.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx + b.jx),
            runtime.newFloat(jy + b.jy)});
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return new Vec2D object (ruby)
     */
    @JRubyMethod(name = "-", required = 1)
    public IRubyObject op_minus(ThreadContext context, IRubyObject other) {
        Vec2 b = null;
        Ruby runtime = context.runtime;
        if (other instanceof Vec2) {
            b = (Vec2) other.toJava(Vec2.class);
        } else {
            throw runtime.newTypeError("argument should be Vec2D");
        }
        return Vec2.rbNew(context, other.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx - b.jx),
            runtime.newFloat(jy - b.jy)});
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject scalar
     * @return new Vec2D object (ruby)
     */
    @JRubyMethod(name = "*")
    public IRubyObject op_mul(ThreadContext context, IRubyObject other) {
        Ruby runtime = context.runtime;
        double scalar = (other instanceof RubyFloat)
                ? ((RubyFloat) other).getValue() : ((RubyFixnum) other).getDoubleValue();
        return Vec2.rbNew(context, this.getMetaClass(),
                new IRubyObject[]{runtime.newFloat(jx * scalar),
                    runtime.newFloat(jy * scalar)});
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject scalar
     * @return new Vec2D object (ruby)
     */
    @JRubyMethod(name = "/", required = 1)
    public IRubyObject op_div(ThreadContext context, IRubyObject other) {
        Ruby runtime = context.runtime;
        double scalar = (other instanceof RubyFloat)
                ? ((RubyFloat) other).getValue() : ((RubyFixnum) other).getDoubleValue();
        if (Math.abs(scalar) < Vec2.EPSILON) {
            return this;
        }
        return Vec2.rbNew(context, this.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx / scalar),
            runtime.newFloat(jy / scalar)});
    }

    /**
     *
     * @param context ThreadContext
     * @return heading IRubyObject radians
     */
    @JRubyMethod(name = "heading")
    public IRubyObject heading(ThreadContext context) {
        return context.runtime.newFloat(Math.atan2(jy, jx));
    }

    /**
     *
     * @param context ThreadContext
     * @return magnitude IRubyObject
     */
    @JRubyMethod(name = "mag")
    public IRubyObject mag(ThreadContext context) {
        double result = 0;
        if (Math.abs(jx) > EPSILON && Math.abs(jy) > EPSILON) {
            result = Math.hypot(jx, jy);
        } else {
            if (Math.abs(jy) > EPSILON) {
                result = Math.abs(jy);
            }
            if (Math.abs(jx) > EPSILON) {
                result = Math.abs(jx);
            }
        }
        return context.runtime.newFloat(result);
    }

    /**
     * Call yield if block given, do nothing if yield == false else set_mag to
     * given scalar
     *
     * @param context ThreadContext
     * @param scalar double value to set
     * @param block should return a boolean (optional)
     * @return magnitude IRubyObject
     */
    @JRubyMethod(name = "set_mag")
    public IRubyObject set_mag(ThreadContext context, IRubyObject scalar, Block block) {
        double new_mag = (Double) scalar.toJava(Double.class);
        if (block.isGiven()) {
            if (!(boolean) block.yield(context, scalar).toJava(Boolean.class)) {
                return this;
            }
        }
        double current = 0;
        if (Math.abs(jx) > EPSILON && Math.abs(jy) > EPSILON) {
            current = Math.hypot(jx, jy);
        } else {
            if (Math.abs(jy) > EPSILON) {
                current = Math.abs(jy);
            }
            if (Math.abs(jx) > EPSILON) {
                current = Math.abs(jx);
            }
        }
        if (current > 0) {
            jx *= new_mag / current;
            jy *= new_mag / current;
        }
        return this;
    }

    /**
     *
     * @param context ThreadContext
     * @return this as a ruby object
     */
    @JRubyMethod(name = "normalize!")
    public IRubyObject normalize_bang(ThreadContext context) {
        double mag = 0;
        if (Math.abs(jx) > EPSILON && Math.abs(jy) > EPSILON) {
            mag = Math.hypot(jx, jy);
        } else {
            if (Math.abs(jx) > EPSILON) {
                mag = Math.abs(jx);
            }
            if (Math.abs(jy) > EPSILON) {
                mag = Math.abs(jy);
            }
        }
        if (mag > 0) {
            jx /= mag;
            jy /= mag;
        }
        return this;
    }

    /**
     *
     * @param context ThreadContext
     * @return new normalized Vec3D object (ruby)
     */
    @JRubyMethod(name = "normalize")
    public IRubyObject normalize(ThreadContext context) {
        double mag = 0;
        Ruby runtime = context.runtime;
        if (Math.abs(jx) > EPSILON && Math.abs(jy) > EPSILON) {
            mag = Math.hypot(jx, jy);
        } else {
            if (Math.abs(jx) > EPSILON) {
                mag = jx;
            }
            if (Math.abs(jy) > EPSILON) {
                mag = jy;
            }
        }
        if (mag < EPSILON) {
            mag = 1.0;
        }
        return Vec2.rbNew(context, this.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx / mag),
            runtime.newFloat(jy / mag)});
    }

    /**
     * Example of a regular ruby class method Use Math rather than RadLut
     * here!!!
     *
     * @param context ThreadContext
     * @param klazz IRubyObject
     * @param scalar input angle in radians
     * @return new Vec2 object (ruby)
     */
    @JRubyMethod(name = "from_angle", meta = true)
    public static IRubyObject from_angle(ThreadContext context, IRubyObject klazz, IRubyObject scalar) {
        Ruby runtime = context.runtime;
        double angle = (scalar instanceof RubyFloat)
                ? ((RubyFloat) scalar).getValue() : ((RubyFixnum) scalar).getDoubleValue();
        return Vec2.rbNew(context, klazz, new IRubyObject[]{
            runtime.newFloat(Math.cos(angle)),
            runtime.newFloat(Math.sin(angle))});
    }

    /**
     * Example of a regular ruby class method
     *
     * @param context ThreadContext
     * @param klazz IRubyObject
     * @return new Vec2 object (ruby)
     */
    @JRubyMethod(name = "random", meta = true)
    public static IRubyObject random_direction(ThreadContext context, IRubyObject klazz) {
        Ruby runtime = context.runtime;
        double angle = Math.random() * Math.PI * 2;
        return Vec2.rbNew(context, klazz, new IRubyObject[]{
            runtime.newFloat(Math.cos(angle)),
            runtime.newFloat(Math.sin(angle))});
    }

    /**
     *
     * @param context ThreadContext
     * @param scalar IRubyObject
     * @return this Vec2 object rotated
     */
    @JRubyMethod(name = "rotate!")
    public IRubyObject rotate_bang(ThreadContext context, IRubyObject scalar) {
        double theta = (scalar instanceof RubyFloat)
                ? ((RubyFloat) scalar).getValue() : ((RubyFixnum) scalar).getDoubleValue();
        double x = (jx * Math.cos(theta) - jy * Math.sin(theta));
        double y = (jx * Math.sin(theta) + jy * Math.cos(theta));
        jx = x;
        jy = y;
        return this;
    }

    /**
     *
     * @param context ThreadContext
     * @param scalar IRubyObject
     * @return a new Vec2 object rotated
     */
    @JRubyMethod(name = "rotate")
    public IRubyObject rotate(ThreadContext context, IRubyObject scalar) {
        Ruby runtime = context.runtime;
        double theta = (scalar instanceof RubyFloat)
                ? ((RubyFloat) scalar).getValue() : ((RubyFixnum) scalar).getDoubleValue();
        IRubyObject[] ary = new IRubyObject[]{
            runtime.newFloat(jx * Math.cos(theta) - jy * Math.sin(theta)),
            runtime.newFloat(jx * Math.sin(theta) + jy * Math.cos(theta))};
        return Vec2.rbNew(context, this.getMetaClass(), ary);
    }

    /**
     *
     * @param context ThreadContext
     * @param args IRubyObject[]
     * @return as a new Vec2 object (ruby)
     */
    @JRubyMethod(name = "lerp", rest = true)
    public IRubyObject lerp(ThreadContext context, IRubyObject[] args) {
        Ruby runtime = context.runtime;
        Arity.checkArgumentCount(runtime, args, 2, 2);
        Vec2 vec = (Vec2) args[0].toJava(Vec2.class);
        double scalar = (args[1] instanceof RubyFloat)
                ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
        assert (scalar >= 0 && scalar < 1.0) :
                "Lerp value " + scalar + " out of range 0..1.0";
        return Vec2.rbNew(context, this.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx + (vec.jx - jx) * scalar),
            runtime.newFloat(jy + (vec.jy - jy) * scalar)});
    }

    /**
     *
     * @param context ThreadContext
     * @param args IRubyObject[]
     * @return this IRubyObject
     */
    @JRubyMethod(name = "lerp!", rest = true)
    public IRubyObject lerp_bang(ThreadContext context, IRubyObject[] args) {
        Arity.checkArgumentCount(context.runtime, args, 2, 2);
        Vec2 vec = (Vec2) args[0].toJava(Vec2.class);
        double scalar = (args[1] instanceof RubyFloat)
                ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
        assert (scalar >= 0 && scalar < 1.0) :
                "Lerp value " + scalar + " out of range 0..1.0";
        jx += (vec.jx - jx) * scalar;
        jy += (vec.jy - jy) * scalar;
        return this;
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject another Vec3D
     * @return angle IRubyObject in radians
     */
    @JRubyMethod(name = "angle_between")
    public IRubyObject angleBetween(ThreadContext context, IRubyObject other) {
        Vec2 vec = null;
        Ruby runtime = context.runtime;
        if (other instanceof Vec2) {
            vec = (Vec2) other.toJava(Vec2.class);
        } else {
            throw runtime.newTypeError("argument should be Vec2D");
        }
        return runtime.newFloat(Math.atan2(jx - vec.jx, jy - vec.jy));
    }

    /**
     *
     * @param context ThreadContext
     * @return IRubyObject copy
     */
    @JRubyMethod(name = {"copy", "dup"})
    public IRubyObject copy(ThreadContext context) {
        Ruby runtime = context.runtime;
        return Vec2.rbNew(context, this.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx),
            runtime.newFloat(jy)});
    }

    /**
     *
     * @param context ThreadContext
     * @return IRubyObject array of float
     */
    @JRubyMethod(name = "to_a")
    public IRubyObject toArray(ThreadContext context) {
        Ruby runtime = context.runtime;
        return RubyArray.newArray(runtime, new IRubyObject[]{
            runtime.newFloat(jx),
            runtime.newFloat(jy)});
    }

    /**
     *
     * To vertex
     *
     * @param context ThreadContext
     * @param object IRubyObject vertex renderer
     */
    @JRubyMethod(name = "to_vertex")
    public void toVertex(ThreadContext context, IRubyObject object) {
        JRender renderer = (JRender) object.toJava(JRender.class);
        renderer.vertex(jx, jy);
    }

    /**
     *
     * To curve vertex
     *
     * @param context ThreadContext
     * @param object IRubyObject vertex renderer
     */
    @JRubyMethod(name = "to_curve_vertex")
    public void toCurveVertex(ThreadContext context, IRubyObject object) {
        JRender renderer = (JRender) object.toJava(JRender.class);
        renderer.curveVertex(jx, jy);
    }

    /**
     * For jruby-9000 we alias to inspect
     *
     * @param context ThreadContext
     * @return IRubyObject to_s
     */
    @JRubyMethod(name = {"to_s", "inspect"})
    public IRubyObject to_s(ThreadContext context) {
        return context.runtime.newString(String.format("Vec2D(x = %4.4f, y = %4.4f)", jx, jy));
    }

    /**
     *
     * @return hash int
     */
    @Override
    public int hashCode() {
        int hash = 5;
        hash = 53 * hash + (int) (Double.doubleToLongBits(this.jx) ^ (Double.doubleToLongBits(this.jx) >>> 32));
        hash = 53 * hash + (int) (Double.doubleToLongBits(this.jy) ^ (Double.doubleToLongBits(this.jy) >>> 32));
        return hash;
    }

    /**
     *
     * Java Equals
     *
     * @param obj Object
     * @return result boolean
     */
    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof Vec2) {
            final Vec2 other = (Vec2) obj;
            if ((Double.compare(jx, (Double) other.jx) == 0)
                    && (Double.compare(jy, (Double) other.jy) == 0)) {
                return true;
            }
        }
        return false;
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return result IRubyObject as boolean
     */
    @JRubyMethod(name = "eql?", required = 1)
    public IRubyObject eql_p(ThreadContext context, IRubyObject other) {
        Ruby runtime = context.runtime;
        if (other == this) {
            return runtime.newBoolean(true);
        }
        if (other instanceof Vec2) {
            Vec2 v = (Vec2) other.toJava(Vec2.class);
            if ((Double.compare(jx, (Double) v.jx) == 0)
                    && (Double.compare(jy, (Double) v.jy) == 0)) {
                return runtime.newBoolean(true);
            }
        }
        return runtime.newBoolean(false);
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return result IRubyObject as boolean
     */
    @JRubyMethod(name = "==", required = 1)
    @Override
    public IRubyObject op_equal(ThreadContext context, IRubyObject other) {
        Ruby runtime = context.runtime;
        if (other == this) {
            return runtime.newBoolean(true);
        }
        if (other instanceof Vec2) {
            Vec2 v = (Vec2) other.toJava(Vec2.class);
            double diff = jx - v.jx;
            if ((diff < 0 ? -diff : diff) > Vec2.EPSILON) {
                return runtime.newBoolean(false);
            }
            diff = jy - v.jy;
            return runtime.newBoolean((diff < 0 ? -diff : diff) < Vec2.EPSILON);
        }
        return runtime.newBoolean(false);
    }
}
