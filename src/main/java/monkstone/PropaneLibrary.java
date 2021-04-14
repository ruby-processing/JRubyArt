/**
 * The purpose of this class is to load the MathTool into ruby-processing runtime
 * Copyright (C) 2015-20 Martin Prout. This code is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation; either version
 * 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package monkstone;

import java.io.IOException;
import monkstone.fastmath.Deglut;
import monkstone.vecmath.vec2.Vec2;
import monkstone.vecmath.vec3.Vec3;
import org.jruby.Ruby;
import org.jruby.runtime.load.Library;

/**
 *
 * @author Martin Prout
 */
public class PropaneLibrary implements Library {

    /**
     *
     * @param runtime
     */
    public static void load(final Ruby runtime) {
        MathToolModule.createMathToolModule(runtime);
        FastNoiseModuleJava.createNoiseModule(runtime);
        SmoothNoiseModuleJava.createNoiseModule(runtime);
        Deglut.createDeglut(runtime);
        Vec2.createVec2(runtime);
        Vec3.createVec3(runtime);
    }

    /**
     *
     * @param runtime
     * @param wrap
     * @throws java.io.IOException
     */
    @Override
    public void load(final Ruby runtime, boolean wrap) throws IOException {
        PropaneLibrary.load(runtime);
    }
}
