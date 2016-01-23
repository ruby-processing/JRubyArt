package monkstone.vecmath;

import processing.core.PApplet;

/**
 *
 * @author Martin Prout
 */
public class AppRender implements JRender {

    final PApplet app;

    /**
     *
     * @param app PApplet
     */
    public AppRender(final PApplet app) {
        this.app = app;
    }

    /**
     *
     * @param x double
     * @param y double
     */
    @Override
    public void vertex(double x, double y) {
        app.vertex((float) x, (float) y);
    }
    
    /**
     *
     * @param x double
     * @param y double
     */
    @Override
    public void curveVertex(double x, double y) {
        app.curveVertex((float) x, (float) y);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void vertex(double x, double y, double z) {
        app.vertex((float) x, (float) y, (float) z);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void normal(double x, double y, double z) {
        app.normal((float) x, (float) y, (float) z);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     * @param u double
     * @param v double
     */
    @Override
    public void vertex(double x, double y, double z, double u, double v) {
        app.vertex((float) x, (float) y, (float) z, (float) u, (float) v);
    }
    
    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void curveVertex(double x, double y, double z) {
        app.curveVertex((float) x, (float) y, (float) z);
    }
}
