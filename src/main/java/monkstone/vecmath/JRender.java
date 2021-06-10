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
    void vertex(double x, double y);

    /**
     *
     * @param x double
     * @param y double
     */
    void curveVertex(double x, double y);

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    void vertex(double x, double y, double z);

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     * @param u double
     * @param v double
     */
    void vertex(double x, double y, double z, double u, double v);

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    void curveVertex(double x, double y, double z);

    /**
     *
     * @param x double
     * @param y double
     * @param z double
     */
    void normal(double x, double y, double z);
}
