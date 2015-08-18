/**
 * The purpose of this tool is to allow JRubyArt users to use an alternative 
 * to processing.org map methods in their sketches Copyright (C) 2015 Martin 
 * Prout. This tool is free software; you can redistribute it and/or modify 
 * it under the terms of the GNU Lesser General Public License as published by 
 * the Free Software Foundation; either version 2.1 of the License, or (at 
 * your option) any later version.
 * 
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package monkstone;

import org.jruby.Ruby;
import org.jruby.RubyClass;
import org.jruby.RubyFloat;
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
     * @param context JRuby runtime
     * @param recv self
     * @param args array of RubyRange (must be be numeric)
     * @return RubyFloat
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
        return mapMt(context, value, first1, last1, first2, last2);
    }

    /**
     *
     * @param context JRuby runtime
     * @param recv self
     * @param args array of RubyRange (must be be numeric)
     * @return RubyFloat
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
       return mapMt(context, value, first1, last1, first2, last2);
    }
    
    /**
     *
     * @param context JRuby runtime
     * @param recv self
     * @param args floats as in processing map function
     * @return RubyFloat
     */
    @JRubyMethod(name = "p5map", rest = true, module = true)
    public static IRubyObject mapProcessing(ThreadContext context, IRubyObject recv, IRubyObject[] args) {
        double value = (Double) args[0].toJava(Double.class);
        double first1 = (Double) args[1].toJava(Double.class);
        double first2 = (Double) args[3].toJava(Double.class);
        double last1 = (Double) args[2].toJava(Double.class);
        double last2 = (Double) args[4].toJava(Double.class);
        return mapMt(context, value, first1, last1, first2, last2);
    }
    
    
    static final RubyFloat mapMt(ThreadContext context, double value, double first1, double last1, double first2, double last2) {   
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

