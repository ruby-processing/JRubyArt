/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package monkstone;

import org.jruby.Ruby;
import org.jruby.RubyClass;
import org.jruby.RubyModule;
import org.jruby.RubyObject;
import org.jruby.RubyRange;
import org.jruby.anno.JRubyMethod;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;

/**
 *
 * @author MartinProut
 */

public class MathTool extends RubyObject {

    /**
     *
     * @param runtime
     */
    public static void createMathTool(Ruby runtime) {
        RubyModule processing = runtime.defineModule("Processing");
        RubyModule module = processing.defineModuleUnder("MathTool");
        module.defineAnnotatedMethods(MathTool.class);
    }

    /**
     *
     * @param context
     * @param recv
     * @param args
     * @return
     */
    @JRubyMethod(name = "map1d", rest = true, module = true)
    public static IRubyObject mapOneD(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double value = (Double) args[0].toJava(Double.class);
        RubyRange r1 = (RubyRange) args[1];
        RubyRange r2 = (RubyRange) args[2];
        double first1 = (Double) r1.first(context).toJava(Double.class);
        double first2 = (Double) r2.first(context).toJava(Double.class);
        double last1 = (Double) r1.last(context).toJava(Double.class);
        double last2 = (Double) r2.last(context).toJava(Double.class);
        double result = first2 + (last2 - first2) * ((value - first1) / (last1 - first1));
        return context.getRuntime().newFloat(result);
    }

    /**
     *
     * @param context
     * @param recv
     * @param args
     * @return
     */
    @JRubyMethod(name = "constrained_map", rest = true, module = true)
    public static IRubyObject constrainedMap(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double value = (Double) args[0].toJava(Double.class);
        RubyRange r1 = (RubyRange) args[1];
        RubyRange r2 = (RubyRange) args[2];
        double first1 = (Double) r1.first(context).toJava(Double.class);
        double first2 = (Double) r2.first(context).toJava(Double.class);
        double last1 = (Double) r1.last(context).toJava(Double.class);
        double last2 = (Double) r2.last(context).toJava(Double.class);
        double max = Math.max(first1, last1);
        double min = Math.min(first1, last1);
        if (value < min) {
            value = min;
        }
        if (value > max) {
            value = max;
        }
        double result = first2 + (last2 - first2) * ((value - first1) / (last1 - first1));
        return context.getRuntime().newFloat(result);
    }

    /**
     *
     * @param runtime
     * @param metaClass
     */
    public MathTool(Ruby runtime, RubyClass metaClass) {
        super(runtime, metaClass);
    }
}
