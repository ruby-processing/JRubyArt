package monkstone.vecmath;

import processing.core.PApplet;
import processing.core.PGraphics;

/**
 * Renderer
 * Copyright (c) 2018 Martin Prout
 */
public class AppRender implements JRender {

    final PGraphics g;

    /**
     *
     * @param app PApplet
     */
    public AppRender(final PApplet app) {
        this.g = app.g;
    }

    /**
     *
     * @param x double
     * @param y double
     */
    @Override
    public void vertex(double x, double y) {
        g.vertex((float) x, (float) y);
    }

    /**
     *
     * @param x double
     * @param y double
     */
    @Override
    public void curveVertex(double x, double y) {
        g.curveVertex((float) x, (float) y);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void vertex(double x, double y, double z) {
        g.vertex((float) x, (float) y, (float) z);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void normal(double x, double y, double z) {
        g.normal((float) x, (float) y, (float) z);
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
        g.vertex((float) x, (float) y, (float) z, (float) u, (float) v);
    }

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    @Override
    public void curveVertex(double x, double y, double z) {
        g.curveVertex((float) x, (float) y, (float) z);
    }
}
