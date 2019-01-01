/* 
 * Copyright (c) 2016-19 Martin Prout
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
package monkstone.slider;

import processing.core.PApplet;
import processing.event.MouseEvent;

public abstract class SliderBar implements Slider {

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
    WheelHandler scrollWheelHandler;

    /**
     *
     * @return
     */
    public float value() {
        return pValue;
    }

    /**
     *
     * @param w
     */
    public void barWidth(int w) {
        if (w < MIN_BAR_WIDTH) {
            pH = MIN_BAR_WIDTH;
        } else {
            pH = (w > MAX_BAR_WIDTH) ? MAX_BAR_WIDTH : w;
        }
    }

    final void limits(float iv, float fv) {
        vMin = iv;
        vMax = fv;
        SliderBar.this.setValue(iv);
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

    /**
     *
     * @param b
     */
    public void externalBorder(int b) {
        externalBorder = b;
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
     */
    public void showBackground() {
        backgroundVisible = true;
    }

    /**
     *
     * @param s
     */
    @Override
    public void labelSize(int s) {
        labelSize = (s < 4) ? 4 : s;
    }

    /**
     * @param back color of the bar
     * @param fill background color of the slider
     */
    public void widgetColors(int back, int fill) {
        sliderBack = back;
        sliderFill = fill;
    }

    abstract boolean mouseOver();

    private void setActive(boolean active) {
        if (active) {
            applet.registerMethod("dispose", this);
            applet.registerMethod("draw", this);
            applet.registerMethod("mouseEvent", this);
        } else {
            applet.unregisterMethod("draw", this);
            applet.unregisterMethod("mouseEvent", this);
        }
    }

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

    public void mouseEvent(MouseEvent evt) {
        if (evt.getAction() == MouseEvent.WHEEL) {
            if (scrollWheelHandler != null) {
                scrollWheelHandler.handleWheel((short) evt.getCount());
            }
        }
    }

    /**
     *
     * @param value
     */
    @Override
    public abstract void setValue(float value);

    abstract void checkKeyboard();

    void change() {
        checkKeyboard();
    }

    /**
     *
     * @return
     */
    @Override
    public float readValue() {
        return pValue;
    }

    /**
     *
     * @param delta
     */
    abstract void changeWithWheel(int delta);

    void deBounce(int n) {
        if (pressOnlyOnce) {
        } else if (deb++ > n) {
            deb = 0;
            pressOnlyOnce = true;
        }
    }

    protected float map(float val, float begIn, float endIn, float beginOut, float endOut) {
        return (beginOut + (endOut - beginOut) * ((val - begIn) / (endIn - begIn)));
    }

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

    @Override
    public void dispose() {
        setActive(false);
    }
}
