package processing.vecmath;

import processing.core.PApplet;

/**
 *
 * @author Martin Prout
 */
public class AppRender implements JRender {

    final PApplet app;

    public AppRender(final PApplet app) {
        this.app = app;
    }

    @Override
    public void vertex(double x, double y) {
        app.vertex((float) x, (float) y);
    }
}
