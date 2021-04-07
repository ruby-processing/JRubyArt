/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package monkstone;

import monkstone.noise.OpenSimplex2S;
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
@JRubyModule(name = "SmoothNoise")
public class SmoothNoiseModuleJava {

    static OpenSimplex2S ng = new OpenSimplex2S(System.currentTimeMillis());

    /**
     *
     * @param runtime Ruby
     */
    public static void createNoiseModule(Ruby runtime) {
        RubyModule noiseModule = runtime.defineModule("SmoothNoise");
        noiseModule.defineAnnotatedMethods(SmoothNoiseModuleJava.class);
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
        double result = 0;
        double one;
        double two;
        double three;
        double four;
        switch (args.length) {
            case 2:
                two = args[1] instanceof RubyFloat ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
                one = args[0] instanceof RubyFloat ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
                result = ng.noise2_XBeforeY(one, two);
                break;
            case 3:
                three = args[2] instanceof RubyFloat ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
                two = args[1] instanceof RubyFloat ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
                one = args[0] instanceof RubyFloat ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
                result = ng.noise3_XYBeforeZ(one, two, three);
                break;
            case 4:
                four = args[3] instanceof RubyFloat ? ((RubyFloat) args[3]).getValue() : ((RubyFixnum) args[3]).getDoubleValue();
                three = args[2] instanceof RubyFloat ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
                two = args[1] instanceof RubyFloat ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
                one = args[0] instanceof RubyFloat ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
                result = ng.noise4_XYBeforeZW(one, two, three, four);
                break;
            default:
                throw new RuntimeException("Min 2D Max 4D Noise");
        }
        return RubyFloat.newFloat(context.runtime, result);
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
        double result = 0;
        double one;
        double two;
        double three;
        double four;
        switch (args.length) {
            case 1:
                one = args[0] instanceof RubyFloat ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
                result = ng.noise2(one, 0);
                break;
            case 2:
                two = args[1] instanceof RubyFloat ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
                one = args[0] instanceof RubyFloat ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
                result = ng.noise2(one, two);
                break;
            case 3:
                three = args[2] instanceof RubyFloat ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
                two = args[1] instanceof RubyFloat ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
                one = args[0] instanceof RubyFloat ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
                result = ng.noise3_Classic(one, two, three);
                break;
            case 4:
                four = args[3] instanceof RubyFloat ? ((RubyFloat) args[3]).getValue() : ((RubyFixnum) args[3]).getDoubleValue();
                three = args[2] instanceof RubyFloat ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
                two = args[1] instanceof RubyFloat ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
                one = args[0] instanceof RubyFloat ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
                result = ng.noise4_Classic(one, two, three, four);
                break;
            default:
                throw new RuntimeException("Maximum of 4D Noise");
        }
        return RubyFloat.newFloat(context.runtime, result);
    }
//    @JRubyMethod(name = "noise_seed", rest = true, module = true)
//    public static IRubyObject noiseSeedImpl(ThreadContext context, IRubyObject recv, IRubyObject arg) {
//        long seed;
//        if (arg instanceof RubyNumeric) {
//            seed = ((RubyNumeric) arg).getLongValue();
//            ng = new OpenSimplex2S(seed);
//            return RubyBoolean.newBoolean(context.runtime, true);
//        }
//       return RubyBoolean.newBoolean(context.runtime, false);
//    }
}
