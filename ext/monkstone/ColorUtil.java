/**
 * This utility allows JRubyArt users to use the processing.org color method 
 * in their sketches Copyright (C) 2015 Martin Prout. 
 * This utility is free software; you can redistribute it and/or modify 
 * it under the terms of the GNU Lesser General Public License as published by 
 * the Free Software Foundation; either version 2.1 of the License, or (at 
 * your option) any later version.
 * 
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package monkstone;

/**
 *
 * @author Martin Prout
 */
public class ColorUtil {

   /**
     * Returns hex long as a positive int unless greater than Integer.MAX_VALUE
     * else return the complement as a negative integer or something like that
     */
    static final int hexLong(long hexlong) {
        long SPLIT = Integer.MAX_VALUE + 1;
        if (hexlong < SPLIT) {
            return (int) hexlong;
        } else {
            return (int) (hexlong - SPLIT * 2L);
        }
    }

    static public int colorString(String hexstring) {
        return java.awt.Color.decode(hexstring).getRGB();
    }

    static public float colorLong(double hex) {
        return (float) hex;
    }
    
    static public int colorLong(long hexlong){
       return hexLong(hexlong);
    }

    static public float colorDouble(double hex){
       return (float)hex;
    }
}
