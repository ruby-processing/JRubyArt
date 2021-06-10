/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package monkstone.slider;

/**
 *
 * @author tux
 */
public interface Slider {

    void dispose();

    void draw();

    /**
     *
     */
    void hideBackground();

    /**
     *
     */
    void hideLabel();

    /**
     *
     */
    void hideNumbers();

    /**
     *
     * @param s
     */
    void labelSize(int s);

    /**
     *
     * @return
     */
    float readValue();

    /**
     *
     * @param value
     */
    void setValue(float value);

    /**
     *
     */
    void showLabel();

    /**
     *
     */
    void showNumbers();

}
