/* 
 * Copyright (c) 2021 Martin Prout
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

public final class DegLutTables {

    /**
     *
     */
   static public float PI = 3.1415927f;

    /**
     *
     */
   public static final float PI2 = PI * 2;
    static private final int SIN_BITS = 15; // 16KB. Adjust for accuracy.
    static private final int SIN_MASK = ~(-1 << SIN_BITS);
    static private final int SIN_COUNT = SIN_MASK + 1;

    private static final float RAD_FULL = PI * 2;
    private static final float DEG_FULL = 360;
    private static final float RAD_TO_INDEX = SIN_COUNT / RAD_FULL;
    private static final float DEG_TO_INDEX = SIN_COUNT / DEG_FULL;

    /**
     * multiply by this to convert from radians to degrees
     */
   public static final float RADIANS_TO_DEGREES = 180f / PI;

    /**
     *
     */
   public static final float RAD_DEG = RADIANS_TO_DEGREES;
    /**
     * multiply by this to convert from degrees to radians
     */
   public static final float DEGREES_TO_RADIANS = PI / 180;

    /**
     *
     */
   public static final float DEG_RAD = DEGREES_TO_RADIANS;

    static private class Sin {

        static float[] table = new float[SIN_COUNT];

        static {
            for (int i = 0; i < SIN_COUNT; i++) {
                table[i] = (float) Math.sin((i + 0.5f) / SIN_COUNT * RAD_FULL);
            }
            for (int i = 0; i < 360; i += 90) {
                table[(int) (i * DEG_TO_INDEX) & SIN_MASK] = (float) Math.sin(i * DEGREES_TO_RADIANS);
            }
        }
    }

    /**
     * Returns the sine in radians from a lookup table.
     * @param radians
     * @return 
     */
   static public float sin(float radians) {
        return Sin.table[(int) (radians * RAD_TO_INDEX) & SIN_MASK];
    }

    /**
     * Returns the cosine in radians from a lookup table.
     * @param radians
     * @return 
     */
   static public float cos(float radians) {
        return Sin.table[(int) ((radians + PI / 2) * RAD_TO_INDEX) & SIN_MASK];
    }

    /**
     * Returns the sine in radians from a lookup table.
     * @param degrees
     * @return 
     */
   static public float sinDeg(float degrees) {
        return Sin.table[(int) (degrees * DEG_TO_INDEX) & SIN_MASK];
    }

    /**
     * Returns the cosine in radians from a lookup table.
     * @param degrees
     * @return 
     */
   static public float cosDeg(float degrees) {
        return Sin.table[(int) ((degrees + 90) * DEG_TO_INDEX) & SIN_MASK];
    }
}

