/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package monkstone.slider;

import processing.core.PApplet;

/**
 *
 * @author tux
 */
public abstract class SimpleSlider implements Slider {//implements Slider {

    int MIN_BAR_WIDTH = 10;
    int MAX_BAR_WIDTH = 30;
    int sliderBack = 0xff909090;
    int sliderFill = 0xff696969;
    int borderColor = 0;
    int numbersColor = 0;
    int labelColor = 0;
    int externalBorder = 0;
    boolean backgroundVisible = true;
    int labelSize = 18;
    int numberSize = 14;
    boolean displayLabel = false;
    boolean displayValue = true;
    int pX;
    int pY;
    int pW;
    int pH;
    float pScaled = 0;
    float pValue = 0;
    String ID;
    boolean pressOnlyOnce = true;
    int deb = 0;
    short wheelCount = 0;
    float vMin = 0;
    float vMax = 15;
    PApplet applet;

    abstract void displayText();

    abstract void drawGui();

    @Override
    public void draw() {
        applet.pushStyle();
        applet.noStroke();
        drawGui();
        displayText();
        applet.popStyle();
        change();
    }

    /**
     *
     */
    @Override
    public void showLabel() {
        displayLabel = true;
    }

    /**
     *
     */
    @Override
    public void hideLabel() {
        displayLabel = false;
    }

    /**
     *
     */
    @Override
    public void showNumbers() {
        displayValue = true;
    }

    /**
     *
     */
    @Override
    public void hideNumbers() {
        displayValue = false;
    }

    void change() {
        checkKeyboard();
    }

    /**
     *
     */
    @Override
    public void hideBackground() {
        backgroundVisible = false;
    }

    /**
     *
     * @return
     */
    @Override
    public float readValue() {
        return pValue;
    }

    abstract boolean mouseOver();

    protected float map(float val, float begIn, float endIn, float beginOut, float endOut) {
        return (beginOut + (endOut - beginOut) * ((val - begIn) / (endIn - begIn)));
    }

    final void limits(float iv, float fv) {
        vMin = iv;
        vMax = fv;
        setValue(iv);
    }

    /**
     *
     * @param s
     */
    @Override
    public void labelSize(int s) {
        labelSize = (s < 4) ? 4 : s;
    }

    void deBounce(int n) {
        if (pressOnlyOnce) {
        } else if (deb++ > n) {
            deb = 0;
            pressOnlyOnce = true;
        }
    }

    abstract void checkKeyboard();

    protected int constrainMap(double val, double begIn, double endIn, double beginOut, double endOut) {
        double max = Math.max(begIn, endIn);
        double min = Math.min(begIn, endIn);
        if (val < min) {
            val = min;
        }
        if (val > max) {
            val = max;
        }
        return (int) ((beginOut + (endOut - beginOut) * ((val - begIn) / (endIn - begIn))));
    }

    private void setActive(boolean active) {
        if (active) {
            applet.registerMethod("dispose", this);
            applet.registerMethod("draw", this);
        } else {
            applet.unregisterMethod("draw", this);
        }
    }

    @Override
    public void dispose() {
        setActive(false);
    }
}
