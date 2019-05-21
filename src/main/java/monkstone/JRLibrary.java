/**
 * The purpose of this class is to load the MathTool etc. into JRuby runtime
 * Copyright (c) 2015-19 Martin Prout. This code is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation; either version
 * 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */

package monkstone;

import java.io.IOException;
import monkstone.arcball.Rarcball;
import monkstone.fastmath.Deglut;
import monkstone.vecmath.vec2.Vec2;
import monkstone.vecmath.vec3.Vec3;
import org.jruby.Ruby;
import org.jruby.runtime.load.Library;

/**
 *
 * @author Martin Prout
 */
public class JRLibrary implements Library{

    /**
     * Loads the extension classes into Ruby runtime
     * @param runtime Ruby
     */
    public static void load(final Ruby runtime) {
        MathToolModule.createMathToolModule(runtime);
        Deglut.createDeglut(runtime);
        Rarcball.createArcBall(runtime);
        Vec2.createVec2(runtime);
        Vec3.createVec3(runtime);
    }

    /**
     *
     * @param runtime Ruby
     * @param wrap boolean
     * @throws java.io.IOException
     */
    @Override
    public void load(final Ruby runtime, boolean wrap) throws IOException {
        load(runtime);
    }
}
