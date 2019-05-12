/**
 * The purpose of this tool is to allow JRubyArt users to use an alternative
 * to processing.org map, lerp and norm methods in their sketches and to implement
 * JRubyArt convenenience method grid(width, height, stepW, stepH) { |x, y| do stuff }
 * Copyright (c) 2015-19 Martin Prout. This tool is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation; either version
 * 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package monkstone;

import org.jruby.Ruby;
import org.jruby.RubyFixnum;
import org.jruby.RubyFloat;
import org.jruby.RubyModule;
import org.jruby.RubyRange;
import org.jruby.anno.JRubyMethod;
import org.jruby.anno.JRubyModule;
import org.jruby.runtime.Block;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;

/**
 *
 * @author Martin Prout
 */
@JRubyModule(name = "MathTool")
public class MathToolModule {

    /**
     *
     * @param runtime Ruby
     */
    public static void createMathToolModule(Ruby runtime) {
        RubyModule mtModule = runtime.defineModule("MathTool");
        mtModule.defineAnnotatedMethods(MathToolModule.class);
    }

    /**
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param args array of RubyRange (must be be numeric)
     * @return mapped value RubyFloat
     */
    @JRubyMethod(name = "map1d", rest = true, module = true)
    public static IRubyObject mapOneD(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double value = (args[0] instanceof RubyFloat)
                ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
        RubyRange r1 = (RubyRange) args[1];
        RubyRange r2 = (RubyRange) args[2];
        double first1 = (r1.first(context) instanceof RubyFloat)
                ? ((RubyFloat) r1.first(context)).getValue() : ((RubyFixnum) r1.first(context)).getDoubleValue();
        double first2 = (r2.first(context) instanceof RubyFloat)
                ? ((RubyFloat) r2.first(context)).getValue() : ((RubyFixnum) r2.first(context)).getDoubleValue();
        double last1 = (r1.last(context) instanceof RubyFloat)
                ? ((RubyFloat) r1.last(context)).getValue() : ((RubyFixnum) r1.last(context)).getDoubleValue();
        double last2 = (r2.last(context) instanceof RubyFloat)
                ? ((RubyFloat) r2.last(context)).getValue() : ((RubyFixnum) r2.last(context)).getDoubleValue();
        return mapMt(context, value, first1, last1, first2, last2);
    }

    /**
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param args array of RubyRange (must be be numeric)
     * @return mapped value RubyFloat
     */
    @JRubyMethod(name = "constrained_map", rest = true, module = true)
    public static IRubyObject constrainedMap(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double value = (args[0] instanceof RubyFloat) ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
        RubyRange r1 = (RubyRange) args[1];
        RubyRange r2 = (RubyRange) args[2];
        double first1 = (r1.first(context) instanceof RubyFloat)
                ? ((RubyFloat) r1.first(context)).getValue() : ((RubyFixnum) r1.first(context)).getDoubleValue();
        double first2 = (r2.first(context) instanceof RubyFloat)
                ? ((RubyFloat) r2.first(context)).getValue() : ((RubyFixnum) r2.first(context)).getDoubleValue();
        double last1 = (r1.last(context) instanceof RubyFloat)
                ? ((RubyFloat) r1.last(context)).getValue() : ((RubyFixnum) r1.last(context)).getDoubleValue();
        double last2 = (r2.last(context) instanceof RubyFloat)
                ? ((RubyFloat) r2.last(context)).getValue() : ((RubyFixnum) r2.last(context)).getDoubleValue();
        double max = Math.max(first1, last1);
        double min = Math.min(first1, last1);
        if (value < min) {
            return mapMt(context, min, first1, last1, first2, last2);
        }
        if (value > max) {
            return mapMt(context, max, first1, last1, first2, last2);
        }
        return mapMt(context, value, first1, last1, first2, last2);
    }

    /**
     *
     * @param context ThreadContext
     * @param recv self IRubyObject
     * @param args floats as in processing map function
     * @return mapped value RubyFloat
     */
    @JRubyMethod(name = "p5map", rest = true, module = true)
    public static IRubyObject mapProcessing(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double value = (args[0] instanceof RubyFloat) ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
        double first1 = (args[1] instanceof RubyFloat) ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
        double first2 = (args[3] instanceof RubyFloat) ? ((RubyFloat) args[3]).getValue() : ((RubyFixnum) args[3]).getDoubleValue();
        double last1 = (args[2] instanceof RubyFloat) ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
        double last2 = (args[4] instanceof RubyFloat) ? ((RubyFloat) args[4]).getValue() : ((RubyFixnum) args[4]).getDoubleValue();
        return mapMt(context, value, first1, last1, first2, last2);
    }

    /**
     * A more correct version than processing.org version
     *
     * @param context ThreadContext
     * @param recv self IRubyObject
     * @param args args[2] should be between 0 and 1.0 if not returns start or
     * stop
     * @return lerped value RubyFloat
     */
    @JRubyMethod(name = "lerp", rest = true, module = true)
    public static IRubyObject lerpP(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double start = (args[0] instanceof RubyFloat) ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
        double stop = (args[1] instanceof RubyFloat) ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
        double amount = (args[2] instanceof RubyFloat) ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
        if (amount <= 0) {
            return args[0];
        }
        if (amount >= 1.0) {
            return args[1];
        }
        return context.runtime.newFloat((1 - amount) * start + (stop * amount));
    }

    /**
     * Identical to p5map(value, low, high, 0, 1). Numbers outside of the range
     * are not clamped to 0 and 1, because out-of-range values are often
     * intentional and useful.
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param args array of args must be be numeric
     * @return mapped value RubyFloat
     */
    @JRubyMethod(name = "norm", rest = true, module = true)
    public static IRubyObject normP(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double value = (args[0] instanceof RubyFloat) ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
        double start = (args[1] instanceof RubyFloat) ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
        double stop = (args[2] instanceof RubyFloat) ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
        return mapMt(context, value, start, stop, 0, 1.0);
    }

    /**
     * Identical to p5map(value, low, high, 0, 1) but 'clamped'. Numbers outside
     * of the range are clamped to 0 and 1,
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param args array of args must be be numeric
     * @return mapped value RubyFloat
     */
    @JRubyMethod(name = "norm_strict", rest = true, module = true)
    public static IRubyObject norm_strict(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        Ruby ruby = context.runtime;
        double value = (args[0] instanceof RubyFloat) ? ((RubyFloat) args[0]).getValue() : ((RubyFixnum) args[0]).getDoubleValue();
        double start = (args[1] instanceof RubyFloat) ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
        double stop = (args[2] instanceof RubyFloat) ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
        double max = Math.max(start, stop);
        double min = Math.min(start, stop);
        if (value < min) {
            return mapMt(context, min, start, stop, 0, 1.0);
        }
        if (value > max) {
            return mapMt(context, max, start, stop, 0, 1.0);
        }
        return mapMt(context, value, start, stop, 0, 1.0);
    }
     // start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1));
    static final RubyFloat mapMt(ThreadContext context, double value, double first1, double last1, double first2, double last2) {
        double result = first2 + (last2 - first2) * ((value - first1) / (last1 - first1));
        return context.runtime.newFloat(result);
    }

    /**
     * Provides processing constrain method as a ruby module method
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param args array of args must be be numeric
     * @return original or limit values
     */
    @JRubyMethod(name = "constrain", rest = true, module = true)
    public static IRubyObject constrainValue(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        RubyFloat value = args[0].convertToFloat();
        RubyFloat start = args[1].convertToFloat();
        RubyFloat stop = args[2].convertToFloat();
        if (value.op_ge(context, start).isTrue() && value.op_le(context, stop).isTrue()) {
            return args[0];
        } else if (value.op_ge(context, start).isTrue()) {
            return args[2];
        } else {
            return args[1];
        }
    }

    /**
     * Provides JRubyArt grid method as a ruby module method
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param args array of args should be Fixnum
     * @param block { |x, y| `do something` }
     * @return nil
     */
    @JRubyMethod(name = "grid", rest = true, module = true)
    public static IRubyObject createGrid(ThreadContext context, IRubyObject recv, IRubyObject[] args, Block block) {
        int row = (int) args[0].toJava(Integer.class);
        int column =  (int) args[1].toJava(Integer.class);
        int rowStep = 1;
        int colStep = 1;
        if (args.length == 4){
        rowStep = (int) args[2].toJava(Integer.class);
        colStep = (int) args[3].toJava(Integer.class);
        }
        if (block.isGiven()) {
              int tempRow = row / rowStep;
              for (int z = 0; z < (tempRow * (column / colStep)); z++){
                  int x = z % tempRow;
                  int y = z / tempRow;
                  block.yieldSpecific(context, context.runtime.newFixnum(x * rowStep), context.runtime.newFixnum(y * colStep));
              }
        }
        return context.nil;

    }
}
