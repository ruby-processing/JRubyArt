/*
* Copyright (c) 2020-2022 Martin Prout
*/
package monkstone;

import monkstone.noise.OpenSimplex2;
import org.jruby.Ruby;
import org.jruby.RubyFixnum;
import org.jruby.RubyFloat;
import org.jruby.RubyModule;
import org.jruby.anno.JRubyMethod;
import org.jruby.anno.JRubyModule;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;

/**
 *
 * @author Martin Prout
 */
@JRubyModule(name = "FastNoise")
public class FastNoiseModuleJava {

    static OpenSimplex2 ng = new OpenSimplex2();
    static long seed = System.currentTimeMillis();
    /**
     *
     * @param runtime Ruby
     */
    public static void createNoiseModule(Ruby runtime) {
        RubyModule noiseModule = runtime.defineModule("FastNoise");
        noiseModule.defineAnnotatedMethods(FastNoiseModuleJava.class);
    }
    
    
    /**
     * Utility method
     *
     * @param obj
     * @return parse float value of object or zero
     */
    private static double jvalue(IRubyObject obj) {
        if (obj instanceof RubyFloat rubyFloat) {
            return rubyFloat.getValue();
        }
        if (obj instanceof RubyFixnum rubyFixnum) {
            return rubyFixnum.getDoubleValue();
        }
        return 0;
    }

    /**
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param args array of numeric values
     * @return mapped value RubyFloat
     */
    @JRubyMethod(name = "tnoise", rest = true, module = true)
    public static IRubyObject terrainNoiseImpl(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double one;
        double two;
        double three;
        double four;
        double result = switch (args.length) {
            case 2 -> {
                two = jvalue(args[1]);
                one = jvalue(args[0]);
                //yield ng.noise2_XBeforeY(one, two);
                yield ng.noise2(seed, one, two);
            }
            case 3 -> {
                three = jvalue(args[2]);
                two = jvalue(args[1]);
                one = jvalue(args[0]);
                yield ng.noise3_ImproveXY(seed, one, two, three);
            }
            case 4 -> {
                four = jvalue(args[3]);
                three = jvalue(args[2]);
                two = jvalue(args[1]);
                one = jvalue(args[0]);
                yield ng.noise4_ImproveXYZ_ImproveXY(seed, one, two, three, four);
            }
            default -> { yield 2; } // yield an invalid value for noise
        };
        if (result != 2) {
            return RubyFloat.newFloat(context.runtime, result);
        } else {
            throw new RuntimeException("Min 2D Max 4D Noise");
        }
    }

    /**
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param args array of numeric values
     * @return mapped value RubyFloat
     */
    @JRubyMethod(name = "noise", rest = true, module = true)
    public static IRubyObject noiseImpl(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double one;
        double two;
        double three;
        double four;
        double result = switch (args.length) {
            case 1 -> {
                one = jvalue(args[0]);
                yield ng.noise2(seed, one, 0);
            }
            case 2 -> {
                two = jvalue(args[1]);
                one = jvalue(args[0]);
                yield ng.noise2(seed, one, two);
            }
            case 3 -> {
                three = jvalue(args[2]);
                two = jvalue(args[1]);
                one = jvalue(args[0]);
                yield ng.noise3_ImproveXY(seed, one, two, three);
            }
            case 4 -> {
                four = jvalue(args[3]);
                three = jvalue(args[2]);
                two = jvalue(args[1]);
                one = jvalue(args[0]);
                yield ng.noise4_ImproveXY_ImproveZW(seed, one, two, three, four);
            }
            default -> { yield 2; } // yield an invalid value for noise
        };
        if (result != 2) {
            return RubyFloat.newFloat(context.runtime, result);
        } else {
            throw new RuntimeException("Min 2D Max 4D Noise");
        }
    }
}

//    @JRubyMethod(name = "noise_seed", rest = true, module = true)
//    public static IRubyObject noiseSeedImpl(ThreadContext context, IRubyObject recv, IRubyObject arg) {
//        long seed;
//        if (arg instanceof RubyNumeric) {
//            seed = ((RubyNumeric) arg).getLongValue();
//            ng = new OpenSimplex2(seed);
//        return RubyBoolean.newBoolean(context.runtime, true);
//        }
//       return RubyBoolean.newBoolean(context.runtime, false);
//    }
//}
