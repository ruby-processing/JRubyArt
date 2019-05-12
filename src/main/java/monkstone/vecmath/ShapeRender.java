package monkstone.vecmath;

import processing.core.PShape;

/**
 *
 * @author Martin Prout
 */
public class ShapeRender implements JRender {

    final PShape shape;

    /**
     *
     * @param shape PShape
     */
    public ShapeRender(final PShape shape) {
        this.shape = shape;

    }

    /**
     *
     * @param x double
     * @param y double
     */
    @Override
    public void vertex(double x, double y) {
        shape.vertex((float) x, (float) y);
    }
    
    /**
     *
     * @param x double
     * @param y double
     */
    @Override
    public void curveVertex(double x, double y) {
        throw new UnsupportedOperationException("Not implemented for this renderer");
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void vertex(double x, double y, double z) {
        shape.vertex((float) x, (float) y, (float) z);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void normal(double x, double y, double z) {
        shape.normal((float) x, (float) y, (float) z);
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
        shape.vertex((float) x, (float) y, (float) z, (float) u, (float) v);
    }
    
    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void curveVertex(double x, double y, double z) {
        throw new UnsupportedOperationException("Not implemented for this renderer");
    }
}
