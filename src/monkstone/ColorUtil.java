/**
 * This utility allows JRubyArt users to use the processing.org color method
 * in their sketches. Includes a method to efficiently convert an cols of web
 * strings to an cols of color int, and another to convert an cols of p5 color
 * (int) to a string that can be used in ruby code (to generate web color cols).
 * Copyright (c) 2015-19 Martin Prout.
 * This utility is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or (at
 * your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package monkstone;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 *
 * @author Martin Prout
 */
public class ColorUtil {

    static final String TOO_BIG = "produces a line too long a line for code";

    /**
     * Returns hex long as a positive int unless greater than Integer.MAX_VALUE
     * else return the complement as a negative integer or something like that
     *
     * @param hexlong long
     * @return rgb int
     */
    static final int hexLong(long hexlong) {
        long SPLIT = Integer.MAX_VALUE + 1;
        if (hexlong < SPLIT) {
            return (int) hexlong;
        } else {
            return (int) (hexlong - SPLIT * 2L);
        }
    }

    /**
     * @param hexstring String
     * @return rgb int
     */
    static public int colorString(String hexstring) {
        return java.awt.Color.decode(hexstring).getRGB();
    }

    /**
     *
     * @param web Array of web (hex) String
     * @return cols of p5 color (int)
     */
    static public int[] webArray(String[] web) {
        int[] result = new int[web.length];
        for (int i = 0; i < web.length; i++) {
            result[i] = java.awt.Color.decode(web[i]).getRGB();
        }
        return result;
    }

    /**
     * Return a ruby string of the form "%w[a b c]" where a, b, c are raw web
     * strings. This string can be used in ruby code.
     *
     * @param p5colors cols of p5 colors (int)
     * @return String for use in ruby
     */
    static public String rubyString(int[] p5colors) {
        if (p5colors.length > 8){ return TOO_BIG;}
        StringBuilder sb = new StringBuilder("%w[");
        for (int p5color : p5colors) {
            sb.append(String.format("#%06X", (0xFFFFFF & p5color)));
            sb.append(' ');
        }
        sb.deleteCharAt(sb.length() - 1);
        sb.append("]\n");
        return sb.toString();
    }

    static public String[] p5ToWeb(int[] p5colors) {
        List<String> list = new ArrayList<>();
        for (int p5color : p5colors) {
            list.add(String.format("#%06X", (0xFFFFFF & p5color)));
        }
        return list.toArray(new String[0]);
    }

    static public int[] shuffle(int[] cols) {
        Random rgen = new Random();  // Random number generator
        for (int i = 0; i < cols.length; i++) {
            int randomPosition = rgen.nextInt(cols.length);
            int temp = cols[i];
            cols[i] = cols[randomPosition];
            cols[randomPosition] = temp;
        }
        return cols;
    }

    /**
     *
     * @param hex double
     * @return hex float
     */
    static public float colorLong(double hex) {
        return (float) hex;
    }

    /**
     *
     * @param hexlong long
     * @return hexlong int
     */
    static public int colorLong(long hexlong) {
        return hexLong(hexlong);
    }

    /**
     *
     * @param hex double
     * @return hex float
     */
    static public float colorDouble(double hex) {
        return (float) hex;
    }

    /**
     *
     * @param hue
     * @param sat
     * @param brightness
     * @return
     */
    static public int hsbToRgB(double hue, double sat, double brightness) {
        return java.awt.Color.HSBtoRGB((float) hue, (float) sat, (float) brightness);
    }
}
