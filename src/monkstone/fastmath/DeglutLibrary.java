package monkstone.fastmath;

import java.io.IOException;
import org.jruby.Ruby;
import org.jruby.runtime.load.Library;

/**
 *
 * @author Martin Prout
 */
public class DeglutLibrary implements Library {

    /**
     *
     * @param runtime Ruby
     */
    public static void load(final Ruby runtime) {
        Deglut.createDeglut(runtime);
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
