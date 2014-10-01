package processing.vecmath;

import processing.core.PShape;

/**
 *
 * @author Martin Prout
 */
public class ShapeRender implements JRender {

    final PShape shape;

    public ShapeRender(final PShape shape) {
        this.shape = shape;

    }

    @Override
    public void vertex(double x, double y) {
        shape.vertex((float) x, (float) y);
    }
}
