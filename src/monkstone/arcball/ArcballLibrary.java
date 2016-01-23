package monkstone.arcball;

import java.io.IOException;
import org.jruby.Ruby;
import org.jruby.runtime.load.Library;

/**
 *
 * @author Martin Prout
 */
public class ArcballLibrary implements Library {
  
    /**
     *
     * @param runtime Ruby
     */
    public static void load(final Ruby runtime) {
        Rarcball.createArcBall(runtime);
    }  

    /**
     *
     * @param runtime Ruby
     * @param wrap boolean
     */
    @Override
    public void load(final Ruby runtime, boolean wrap) throws IOException {
        load(runtime);
    }
}
