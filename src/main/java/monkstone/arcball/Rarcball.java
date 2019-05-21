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

package monkstone.arcball;

import org.jruby.Ruby;
import org.jruby.RubyClass;
import org.jruby.RubyFloat;
import org.jruby.RubyFixnum;
import org.jruby.RubyModule;
import org.jruby.RubyObject;
import org.jruby.RubySymbol;
import org.jruby.anno.JRubyClass;
import org.jruby.anno.JRubyMethod;
import org.jruby.runtime.Arity;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;
import processing.core.PApplet;

/**
 *
 * @author Martin Prout
 */
@JRubyClass(name = "ArcBall")
public class Rarcball extends RubyObject {

    private static final long serialVersionUID = -8164248008668234947L;

    /**
     *
     * @param runtime Ruby
     */
    public static void createArcBall(final Ruby runtime) {
        RubyModule processing = runtime.defineModule("Processing");
        RubyModule arcBallModule = processing.defineModuleUnder("ArcBall");
        arcBallModule.defineAnnotatedMethods(Rarcball.class);
    }

    /**
     *
     * @param runtime Ruby
     * @param metaClass RubyClass
     */
    public Rarcball(Ruby runtime, RubyClass metaClass) {
        super(runtime, metaClass);
    }

    /**
     * Initialize a new instance of Arcball (without Constrain)
     * @param context ThreadContext
     * @param self IRubyObject
     * @param args optional (no args jx = 0, jy = 0)
     */
    @JRubyMethod(name = "init", meta = true, rest = true, required = 1, optional = 3)

    public static void init(ThreadContext context, IRubyObject self, IRubyObject args[]) {
        int count = Arity.checkArgumentCount(context.runtime, args, 1, 4);
        if (count == 4) {
            PApplet parent = (PApplet) args[0].toJava(PApplet.class);
            double cx = (args[1] instanceof RubyFloat)
                    ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
            double cy = (args[2] instanceof RubyFloat)
                    ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
            double radius = (args[3] instanceof RubyFloat)
                    ? ((RubyFloat) args[3]).getValue() : ((RubyFixnum) args[3]).getDoubleValue();
            new Arcball(parent, cx, cy, radius).setActive(true);
        }
        if (count == 3) {
            PApplet parent = (PApplet) args[0].toJava(PApplet.class);
            double cx = (args[1] instanceof RubyFloat)
                    ? ((RubyFloat) args[1]).getValue() : ((RubyFixnum) args[1]).getDoubleValue();
            double cy = (args[2] instanceof RubyFloat)
                    ? ((RubyFloat) args[2]).getValue() : ((RubyFixnum) args[2]).getDoubleValue();
            new Arcball(parent, cx, cy, parent.width * 0.8f).setActive(true);
        }
        if (count == 1) {
            PApplet parent = (PApplet) args[0].toJava(PApplet.class);
            new Arcball(parent).setActive(true);
        }        
    }

    /**
     *
     * @param context
     * @param self
     * @param args optional (no args jx = 0, jy = 0)
     */
    @JRubyMethod(name = "constrain", meta = true, rest = true, required = 1, optional = 1)

    public static void constrain(ThreadContext context, IRubyObject self, IRubyObject args[]) {
        int count = Arity.checkArgumentCount(context.runtime, args, 1, 2);
        RubySymbol zaxis = RubySymbol.newSymbol(context.runtime, "zaxis");
        RubySymbol xaxis = RubySymbol.newSymbol(context.runtime, "xaxis");
        PApplet parent = (PApplet) args[0].toJava(PApplet.class);
        if (count == 2) {
            if (xaxis == args[1]) {
                new Arcball(parent, Constrain.XAXIS).setActive(true);
            }
            if (zaxis == args[1]) {
                new Arcball(parent, Constrain.ZAXIS).setActive(true);
            }
        } else {
            new Arcball(parent, Constrain.YAXIS).setActive(true);
        }
    }
}
