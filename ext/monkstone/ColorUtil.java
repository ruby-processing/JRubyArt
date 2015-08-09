/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package monkstone;

/**
 *
 * @author tux
 */
public class ColorUtil {

   /**
     * Math.pow(2, 31) = 2147483648L Math.pow(2, 32) = 4294967296L
     */
    static final int hexLong(long hexlong) {
        if (hexlong <= 2147483648L) {
            return (int) hexlong;
        } else {
            return (int) (hexlong - 4294967296L);
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
