package monkstone.vecmath;

/**
 *
 * @author Martin Prout
 */
public interface JRender {

    /**
     *
     * @param x double
     * @param y double
     */
    public void vertex(double x, double y);

    /**
     *
     * @param x double
     * @param y double
     */
    public void curveVertex(double x, double y);

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    public void vertex(double x, double y, double z);

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     * @param u double
     * @param v double
     */
    public void vertex(double x, double y, double z, double u, double v);

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    public void curveVertex(double x, double y, double z);

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    public void normal(double x, double y, double z);
}
