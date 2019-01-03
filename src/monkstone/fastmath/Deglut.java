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

package monkstone.fastmath;

import org.jruby.Ruby;
import org.jruby.RubyInteger;
import org.jruby.RubyModule;
import org.jruby.anno.JRubyModule;
import org.jruby.anno.JRubyMethod;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;

/**
*
* @author Martin Prout
*/
@JRubyModule(name = "DegLut")
public class Deglut {

  /**
  * Lookup table for degree cosine/sine, has a fixed precision 1.0
  * degrees Quite accurate but imprecise
  *
  * @author Martin Prout <mamba2928@yahoo.co.uk>
  */
  static final double[] SIN_DEG_LUT = new double[91];
  /**
  *
  */
  public static final double TO_RADIANS = Math.PI / 180;
  /**
  *
  */
  private static boolean initialized = false;

  private final static int NINETY = 90;
  private final static int FULL = 360;
  private static final long serialVersionUID = -1466528933765940101L;

  /**
  * Initialize sin table with values (first quadrant only)
  */
  public static final void initTable() {
    if (initialized == false) {
      for (int i = 0; i <= NINETY; i++) {
        SIN_DEG_LUT[i] = Math.sin(TO_RADIANS * i);
      }
      initialized = true;
    }
  }

  /**
  *
  * @param runtime Ruby
  */

  public static void createDeglut(final Ruby runtime){
    RubyModule deglutModule = runtime.defineModule("DegLut");
    deglutModule.defineAnnotatedMethods(Deglut.class);
    Deglut.initTable();
  }
    

  /**
  *
  * @param context ThreadContext
  * @param recv IRubyObject
  * @param other IRubyObject degrees
  * @return sin IRubyObject
  */
  @JRubyMethod(name = "sin", module = true)

  public static IRubyObject sin(ThreadContext context, IRubyObject recv, IRubyObject other) {
    int thet = (int) ((RubyInteger)other).getLongValue();
    while (thet < 0) {
      thet += FULL; // Needed because negative modulus plays badly in java
    }
    int theta = thet % FULL;
    int y = theta % NINETY;
    double result = (theta < NINETY) ? SIN_DEG_LUT[y] : (theta < 180)
    ? SIN_DEG_LUT[NINETY - y] : (theta < 270)
    ? -SIN_DEG_LUT[y] : -SIN_DEG_LUT[NINETY - y];
    return context.runtime.newFloat(result);
  }

  /**
  *
  * @param context ThreadContext
  * @param recv IRubyObject
  * @param other IRubyObject degrees
  * @return cos IRubyObject
  */
  @JRubyMethod(name = "cos", module = true)
  public static IRubyObject cos(ThreadContext context, IRubyObject recv, IRubyObject other) {
    int thet = (int) ((RubyInteger)other).getLongValue();
    while (thet < 0) {
      thet += FULL; // Needed because negative modulus plays badly in java
    }
    int theta = thet % FULL;
    int y = theta % NINETY;
    double result = (theta < NINETY) ? SIN_DEG_LUT[NINETY - y] : (theta < 180)
    ? -SIN_DEG_LUT[y] : (theta < 270)
    ? -SIN_DEG_LUT[NINETY - y] : SIN_DEG_LUT[y];
    return context.runtime.newFloat(result);
  }
}
