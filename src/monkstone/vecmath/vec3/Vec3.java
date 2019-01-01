package monkstone.vecmath.vec3;

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
import org.jruby.runtime.Block;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;
import monkstone.vecmath.JRender;
import monkstone.vecmath.vec2.Vec2;

/**
 *
 * @author Martin Prout
 */
@JRubyClass(name = "Vec3D")
public final class Vec3 extends RubyObject {

    private static final long serialVersionUID = 4563517343762009867L;

    /**
     *
     * @param runtime Ruby
     */
    public static void createVec3(final Ruby runtime) {
        RubyClass vec3Cls = runtime.defineClass("Vec3D", runtime.getObject(), (Ruby runtime1, RubyClass rubyClass) -> new Vec3(runtime1, rubyClass));
        vec3Cls.defineAnnotatedMethods(Vec3.class);
    }

    static final double EPSILON = 9.999999747378752e-05; // matches processing.org EPSILON
    double jx = 0;
    double jy = 0;
    double jz = 0;

    /**
     *
     * @param context ThreadContext
     * @param klazz IRubyObject
     * @param args optional (no args jx = 0, jy = 0, jz = 0) (2 args jz = 0)
     * @return new Vec3 object (ruby)
     */
    @JRubyMethod(name = "new", meta = true, rest = true)
    public final static IRubyObject rbNew(ThreadContext context, IRubyObject klazz, IRubyObject... args) {
        Vec3 vec = (Vec3) ((RubyClass) klazz).allocate();
        vec.init(context, args);
        return vec;
    }

    /**
     *
     * @param runtime Ruby
     * @param klass RubyClass
     */
    public Vec3(Ruby runtime, RubyClass klass) {
        super(runtime, klass);
    }

    void init(ThreadContext context, IRubyObject... args) {
        int count = args.length;
        if (count >= 2) {
            jx = (args[0] instanceof RubyFloat)
                    ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
            jy = (args[1] instanceof RubyFloat)
                    ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
        }
        if (count == 3) {
            jz = (args[2] instanceof RubyFloat)
                    ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
        } // allow ruby ducktyping in constructor
        if (count == 1) {
            if (!(args[0].respondsTo("x"))) {
                throw context.runtime.newTypeError(args[0].getType() + " doesn't respond_to :x & :y");
            }
            jx = ((args[0].callMethod(context, "x")) instanceof RubyFloat)
                    ? ((RubyFloat) args[0].callMethod(context, "x")).getValue() : ((RubyFixnum) args[0].callMethod(context, "x")).getDoubleValue();
            jy = ((args[0].callMethod(context, "y")) instanceof RubyFloat)
                    ? ((RubyFloat) args[0].callMethod(context, "y")).getValue() : ((RubyFixnum) args[0].callMethod(context, "y")).getDoubleValue();
            if (!(args[0].respondsTo("z"))) {
                return;
            } // allow promotion from 2D to 3D, sets jz = 0
            jz = ((args[0].callMethod(context, "z")) instanceof RubyFloat) ? ((RubyFloat) args[0].callMethod(context, "z")).getValue() : ((RubyFixnum) args[0].callMethod(context, "z")).getDoubleValue();
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
     * @return z IRubyObject
     */
    @JRubyMethod(name = "z")
    public IRubyObject getZ(ThreadContext context) {
        return context.runtime.newFloat(jz);
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
     * @return z IRubyObject
     */
    @JRubyMethod(name = "z=")
    public IRubyObject setZ(ThreadContext context, IRubyObject other) {
        if (other instanceof RubyFloat) {
            jz = ((RubyFloat) other).getValue();
        } else {
            jz = ((RubyFixnum) other).getDoubleValue();
        }
        return other;
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
            } else if (key == RubySymbol.newSymbol(runtime, "z")) {
                return runtime.newFloat(jz);
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
            } else if (key == RubySymbol.newSymbol(runtime, "z")) {
                jz = (value instanceof RubyFloat)
                        ? ((RubyFloat) value).getValue() : ((RubyFixnum) value).getDoubleValue();
            } else {
                throw runtime.newIndexError("invalid key");
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
     * @return distance float
     */
    @JRubyMethod(name = "dist", required = 1)
    public IRubyObject dist(ThreadContext context, IRubyObject other) {
        Vec3 b = null;
        if (other instanceof Vec3) {
            b = (Vec3) other.toJava(Vec3.class);
        } else {
            throw context.runtime.newTypeError("argument should be Vec3D");
        }
        double result = Math.sqrt((jx - b.jx) * (jx - b.jx) + (jy - b.jy) * (jy - b.jy) + (jz - b.jz) * (jz - b.jz));
        return context.runtime.newFloat(result);
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return distance squared float
     */
    @JRubyMethod(name = "dist_squared", required = 1)
    public IRubyObject dist_squared(ThreadContext context, IRubyObject other) {
        Vec3 b = null;
        if (other instanceof Vec3) {
            b = (Vec3) other.toJava(Vec3.class);
        } else {
            throw context.runtime.newTypeError("argument should be Vec3D");
        }
        double result = (jx - b.jx) * (jx - b.jx) + (jy - b.jy) * (jy - b.jy) + (jz - b.jz) * (jz - b.jz);
        return context.runtime.newFloat(result);
    }

    /**
     *
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return cross product IRubyObject
     */
    @JRubyMethod(name = "cross", required = 1)
    public IRubyObject cross(ThreadContext context, IRubyObject other) {
        Ruby runtime = context.runtime;
        Vec3 vec = null;
        if (other instanceof Vec3) {
            vec = (Vec3) other.toJava(Vec3.class);
        } else {
            throw runtime.newTypeError("argument should be Vec3D");
        }
        return Vec3.rbNew(context, other.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jy * vec.jz - jz * vec.jy),
            runtime.newFloat(jz * vec.jx - jx * vec.jz),
            runtime.newFloat(jx * vec.jy - jy * vec.jx)
        }
        );
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return dot product IRubyObject
     */
    @JRubyMethod(name = "dot", required = 1)
    public IRubyObject dot(ThreadContext context, IRubyObject other) {
        Ruby runtime = context.runtime;
        Vec3 b = null;
        if (other instanceof Vec3) {
            b = (Vec3) other.toJava(Vec3.class);
        } else {
            throw runtime.newTypeError("argument should be Vec3D");
        }
        return runtime.newFloat(jx * b.jx + jy * b.jy + jz * b.jz);
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return new Vec3 object (ruby)
     */
    @JRubyMethod(name = "+", required = 1)
    public IRubyObject op_add(ThreadContext context, IRubyObject other) {
        Ruby runtime = context.runtime;
        Vec3 b = (Vec3) other.toJava(Vec3.class);
        return Vec3.rbNew(context, other.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx + b.jx),
            runtime.newFloat(jy + b.jy),
            runtime.newFloat(jz + b.jz)});
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject
     * @return new Vec3 object (ruby)
     */
    @JRubyMethod(name = "-")
    public IRubyObject op_sub(ThreadContext context, IRubyObject other) {
        Ruby runtime = context.runtime;
        Vec3 b = null;
        if (other instanceof Vec3) {
            b = (Vec3) other.toJava(Vec3.class);
        } else {
            throw runtime.newTypeError("argument should be Vec3D");
        }
        return Vec3.rbNew(context, other.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx - b.jx),
            runtime.newFloat(jy - b.jy),
            runtime.newFloat(jz - b.jz)});
    }

    /**
     *
     * @param context ThreadContext
     * @param scalar IRubyObject
     * @return new Vec3 object (ruby)
     */
    @JRubyMethod(name = "*", required = 1)
    public IRubyObject op_mul(ThreadContext context, IRubyObject scalar) {
        Ruby runtime = context.runtime;
        double multi = (scalar instanceof RubyFloat)
                ? ((RubyFloat) scalar).getValue() : ((RubyFixnum) scalar).getDoubleValue();
        return Vec3.rbNew(context, this.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx * multi),
            runtime.newFloat(jy * multi),
            runtime.newFloat(jz * multi)});
    }

    /**
     *
     * @param context ThreadContext
     * @param scalar IRubyObject
     * @return new Vec3 object (ruby)
     */
    @JRubyMethod(name = "/", required = 1)
    public IRubyObject op_div(ThreadContext context, IRubyObject scalar) {
        Ruby runtime = context.runtime;
        double divisor = (scalar instanceof RubyFloat)
                ? ((RubyFloat) scalar).getValue() : ((RubyFixnum) scalar).getDoubleValue();
        if (Math.abs(divisor) < Vec3.EPSILON) {
            return this;
        }
        return Vec3.rbNew(context, this.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx / divisor),
            runtime.newFloat(jy / divisor),
            runtime.newFloat(jz / divisor)});
    }

    /**
     *
     * @param context ThreadContext
     * @return magnitude squared IRubyObject
     */
    @JRubyMethod(name = "mag_squared")
    public IRubyObject mag_squared(ThreadContext context) {
        return context.runtime.newFloat(jx * jx + jy * jy + jz * jz);
    }

    /**
     *
     * @param context ThreadContext
     * @return magnitude IRubyObject
     */
    @JRubyMethod(name = "mag")
    public IRubyObject mag(ThreadContext context) {
        return context.runtime.newFloat(Math.sqrt(jx * jx + jy * jy + jz * jz));
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
        if (block.isGiven()) {
            if (!(boolean) block.yield(context, scalar).toJava(Boolean.class)) {
                return this;
            }
        }
        double new_mag = (scalar instanceof RubyFloat)
                ? ((RubyFloat) scalar).getValue() : ((RubyFixnum) scalar).getDoubleValue();
        double current = Math.sqrt(jx * jx + jy * jy + jz * jz);
        if (current > EPSILON) {
            jx *= new_mag / current;
            jy *= new_mag / current;
            jz *= new_mag / current;
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
        if (Math.abs(jx) < EPSILON && Math.abs(jy) < EPSILON && Math.abs(jz) < EPSILON) {
            return this;
        }
        double mag = Math.sqrt(jx * jx + jy * jy + jz * jz);
        jx /= mag;
        jy /= mag;
        jz /= mag;
        return this;
    }

    /**
     *
     * @param context ThreadContext
     * @return new normalized Vec3D object (ruby)
     */
    @JRubyMethod(name = "normalize")
    public IRubyObject normalize(ThreadContext context) {
        Ruby runtime = context.runtime;
        double mag = Math.sqrt(jx * jx + jy * jy + jz * jz);
        if (mag < EPSILON) {
            return Vec3.rbNew(context, this.getMetaClass(), new IRubyObject[]{
                runtime.newFloat(jx),
                runtime.newFloat(jy),
                runtime.newFloat(jz)});
        }
        return Vec3.rbNew(context, this.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx / mag),
            runtime.newFloat(jy / mag),
            runtime.newFloat(jz / mag)});
    }

    /**
     * Example of a regular ruby class method
     *
     * @param context ThreadContext
     * @param klazz IRubyObject
     * @return new random Vec3D object (ruby)
     */
    @JRubyMethod(name = "random", meta = true)
    public static IRubyObject random_direction(ThreadContext context, IRubyObject klazz) {
        Ruby runtime = context.runtime;
        double angle = Math.random() * Math.PI * 2;
        double vz = Math.random() * 2 - 1;
        double vx = Math.sqrt(1 - vz * vz) * Math.cos(angle);
        double vy = Math.sqrt(1 - vz * vz) * Math.sin(angle);
        return Vec3.rbNew(context, klazz, new IRubyObject[]{
            runtime.newFloat(vx),
            runtime.newFloat(vy),
            runtime.newFloat(vz)});
    }

    /**
     *
     * @param context ThreadContext
     * @param other IRubyObject another Vec3D
     * @return angle IRubyObject in radians
     */
    @JRubyMethod(name = "angle_between")
    public IRubyObject angleBetween(ThreadContext context, IRubyObject other) {
        Ruby runtime = context.runtime;
        Vec3 vec = (Vec3) other.toJava(Vec3.class);
        // We get NaN if we pass in a zero vector which can cause problems
        // Zero seems like a reasonable angle between a (0,0,0) vector and something else
        if (jx == 0 && jy == 0 && jz == 0) {
            return runtime.newFloat(0.0);
        }
        if (vec.jx == 0 && vec.jy == 0 && vec.jz == 0) {
            return runtime.newFloat(0.0);
        }
        double dot = jx * vec.jx + jy * vec.jy + jz * vec.jz;
        double v1mag = Math.sqrt(jx * jx + jy * jy + jz * jz);
        double v2mag = Math.sqrt(vec.jx * vec.jx + vec.jy * vec.jy + vec.jz * vec.jz);
        // This should be a number between -1 and 1, since it's "normalized"
        double amt = dot / (v1mag * v2mag);
        if (amt <= -1) {
            return runtime.newFloat(Math.PI);
        } else if (amt >= 1) {
            return runtime.newFloat(0.0);
        }
        return runtime.newFloat(Math.acos(amt));
    }

    /**
     *
     * @param context ThreadContext
     * @return IRubyObject copy
     */
    @JRubyMethod(name = {"copy", "dup"})
    public IRubyObject copy(ThreadContext context) {
        Ruby runtime = context.runtime;
        return Vec3.rbNew(context, this.getMetaClass(), new IRubyObject[]{
            runtime.newFloat(jx),
            runtime.newFloat(jy),
            runtime.newFloat(jz)});
    }

    /**
     *
     * @param context ThreadContext
     * @return IRubyObject array of float
     */
    @JRubyMethod(name = "to_a")
    public IRubyObject toArray(ThreadContext context) {
        Ruby runtime = context.runtime;
        return RubyArray.newArray(context.runtime, new IRubyObject[]{
            runtime.newFloat(jx),
            runtime.newFloat(jy),
            runtime.newFloat(jz)});
    }

    /**
     * To vertex
     *
     * @param context ThreadContext
     * @param object IRubyObject vertex renderer
     */
    @JRubyMethod(name = "to_vertex")
    public void toVertex(ThreadContext context, IRubyObject object) {
        JRender renderer = (JRender) object.toJava(JRender.class);
        renderer.vertex(jx, jy, jz);
    }

    /**
     * To curve vertex
     *
     * @param context ThreadContext
     * @param object IRubyObject vertex renderer
     */
    @JRubyMethod(name = "to_curve_vertex")
    public void toCurveVertex(ThreadContext context, IRubyObject object) {
        JRender renderer = (JRender) object.toJava(JRender.class);
        renderer.curveVertex(jx, jy, jz);
    }

    /**
     * Sends this Vec3D as a processing vertex uv
     *
     * @param context ThreadContext
     * @param args IRubyObject[]
     */
    @JRubyMethod(name = "to_vertex_uv", rest = true)
    public void toVertexUV(ThreadContext context, IRubyObject... args) {
        int count = args.length;
        double u = 0;
        double v = 0;
        if (count == 3) {
            u = (args[1] instanceof RubyFloat)
                    ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
            v = (args[2] instanceof RubyFloat)
                    ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
        }
        if (count == 2) {
            Vec2 texture = (Vec2) args[1].toJava(Vec2.class);
            u = texture.javax();
            v = texture.javay();
        }
        JRender renderer = (JRender) args[0].toJava(JRender.class);
        renderer.vertex(jx, jy, jz, u, v);
    }

    /**
     * Sends this Vec3D as a processing normal
     *
     * @param context ThreadContext
     * @param object IRubyObject vertex renderer
     */
    @JRubyMethod(name = "to_normal")
    public void toNormal(ThreadContext context, IRubyObject object) {
        JRender renderer = (JRender) object.toJava(JRender.class);
        renderer.normal(jx, jy, jz);
    }

    /**
     * For jruby-9000 we alias to inspect
     *
     * @param context ThreadContext
     * @return IRubyObject to_s
     */
    @JRubyMethod(name = {"to_s", "inspect"})
    public IRubyObject to_s(ThreadContext context) {
        return context.runtime.newString(String.format("Vec3D(x = %4.4f, y = %4.4f, z = %4.4f)", jx, jy, jz));
    }

    /**
     * Java hash
     *
     * @return hash int
     */
    @Override
    public int hashCode() {
        int hash = 7;
        hash = 97 * hash + (int) (Double.doubleToLongBits(this.jx) ^ (Double.doubleToLongBits(this.jx) >>> 32));
        hash = 97 * hash + (int) (Double.doubleToLongBits(this.jy) ^ (Double.doubleToLongBits(this.jy) >>> 32));
        hash = 97 * hash + (int) (Double.doubleToLongBits(this.jz) ^ (Double.doubleToLongBits(this.jz) >>> 32));
        return hash;
    }

    /**
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
        if (obj instanceof Vec3) {
            final Vec3 other = (Vec3) obj;
            if ((Double.compare(jx, (Double) other.jx) == 0)
                    && (Double.compare(jy, (Double) other.jy) == 0)
                    && (Double.compare(jz, (Double) other.jz) == 0)) {
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
        if (other instanceof Vec3) {
            Vec3 v = (Vec3) other.toJava(Vec3.class);
            if ((Double.compare(jx, (Double) v.jx) == 0)
                    && (Double.compare(jy, (Double) v.jy) == 0)
                    && (Double.compare(jz, (Double) v.jz) == 0)) {
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
        if (other instanceof Vec3) {
            Vec3 v = (Vec3) other.toJava(Vec3.class);
            double diff = jx - v.jx;
            if ((diff < 0 ? -diff : diff) > Vec3.EPSILON) {
                return runtime.newBoolean(false);
            }
            diff = jy - v.jy;
            if ((diff < 0 ? -diff : diff) > Vec3.EPSILON) {
                return runtime.newBoolean(false);
            }
            diff = jz - v.jz;
            return runtime.newBoolean((diff < 0 ? -diff : diff) < Vec3.EPSILON);
        }
        return runtime.newBoolean(false);
    }
}
