package monkstone.vecmath;

import processing.core.PGraphics;

/**
 *
 * @author Martin Prout
 */
public class GfxRender implements JRender {

    final PGraphics graphics;

    /**
     *
     * @param graphics PGraphics
     */
    public GfxRender(final PGraphics graphics) {
        this.graphics = graphics;
    }

    /**
     *
     * @param x double
     * @param y double
     */
    @Override
    public void vertex(double x, double y) {
        graphics.vertex((float) x, (float) y);
    }

    /**
     *
     * @param x double
     * @param y double
     */
    @Override
    public void curveVertex(double x, double y) {
        graphics.curveVertex((float) x, (float) y);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void vertex(double x, double y, double z) {
        graphics.vertex((float) x, (float) y, (float) z);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void normal(double x, double y, double z) {
        graphics.normal((float) x, (float) y, (float) z);
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
        graphics.vertex((float) x, (float) y, (float) z, (float) u, (float) v);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void curveVertex(double x, double y, double z) {
        graphics.curveVertex((float) x, (float) y, (float) z);
    }
}
