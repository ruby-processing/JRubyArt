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

    static final long hexString(String hexstring) {
        if (hexstring.startsWith("#")) {
            String bare = hexstring.substring(1);
            String pad = String.format("%-6s", bare).replace(' ', '0');
            String hex = String.format("%8s", pad).replace(' ', 'F');
            return Long.parseLong(hex, 16);
        }
        return 0;
    }
    /**
      Math.pow(2, 31) = 2147483648L
      Math.pow(2, 32) = 4294967296L
    */
    static final int hexLong(long hexlong) {
        if (hexlong <= 2147483648L) {
            return (int) hexlong;
        } else {
            return (int) (hexlong - 4294967296L);
        }
    }
    
    static public int colorString(String hexstring){
       return hexLong(hexString(hexstring));
    }
    
    static public int colorLong(long hexlong){
       return hexLong(hexlong);
    }
}
