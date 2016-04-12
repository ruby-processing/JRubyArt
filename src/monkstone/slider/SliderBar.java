/* 
 * Copyright (c) 2016 Martin Prout
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
import processing.core.PConstants;
import static processing.core.PConstants.*;

public class SliderBar {

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
    boolean horizontal = true;
    private final PApplet applet;
    private final WheelHandler scrollWheelHandler;
    /**
     *
     * @param outer
     * @param x top left position x
     * @param y left top position y
     * @param length width or height
     * @param beginRange start range
     * @param endRange end range
     * @param label widget label/ID
     */
    public SliderBar(final PApplet outer, int x, int y, int length, float beginRange, float endRange, String label) {
        this.applet = outer;
        this.scrollWheelHandler = (short delta) -> {
            changeWithWheel(delta);
        };
        setActive(true);
        pX = x;
        pY = y;
        pW = length;
        pH = 10;
        ID = label;
        limits(beginRange, endRange);
    }

    /**
     *
     * @return
     */
    public float value() {
        return pValue;
    }

    public void vertical() {
        horizontal = false;
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

    private void limits(float iv, float fv) {
        vMin = iv;
        vMax = fv;
        SliderBar.this.setValue(iv);
    }

    /**
     *
     */
    public void showLabel() {
        displayLabel = true;
    }

    /**
     *
     */
    public void hideLabel() {
        displayLabel = false;
    }

    /**
     *
     */
    public void showNumbers() {
        displayValue = true;
    }

    /**
     *
     */
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
    public void labelSize(int s) {
        labelSize = (s < 4) ? 4 : s;
    }

    /**
     *
     * @param col color of the bar
     */
    public void sliderColor(int col) {

    }

    /**
     * @param back color of the bar
     * @param fill background color of the slider
     */
    public void widgetColors(int back, int fill) {
        sliderBack = back;
        sliderFill = fill;
    }

    private boolean mouseOver() {
        boolean result = false;
        if (horizontal) {
            if (applet.mouseX >= pX && applet.mouseX <= pX + pW && applet.mouseY >= pY && applet.mouseY <= pY + pH) {
                result = true;
            }
        } else if (applet.mouseX >= pX && applet.mouseX <= pX + pH && applet.mouseY >= pY && applet.mouseY <= pY + pW) {
            result = true;
        }
        return result;
    }

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

    private void displayText() {
        String lFormat = "%d";
        if (displayLabel) {
            applet.fill(labelColor);
            applet.textSize(labelSize);
            applet.textAlign(PConstants.CENTER);
            if (horizontal) {
                applet.text(Integer.toString((int) pValue), pX + pW / 2, pY + pH / 2 + labelSize / 2 - 2);
            } else {
                applet.pushMatrix();
                applet.translate(pX + pH / 2, pY + pW / 2);
                applet.rotate(HALF_PI);
                applet.text(Integer.toString((int) pValue), 0, 0 + labelSize / 2 - 2);
                applet.popMatrix();
            }
        }
        if (displayValue) {
            applet.textSize(numberSize);
            applet.fill(numbersColor);
            if (horizontal) {
                applet.textAlign(PConstants.LEFT);
                applet.text(String.format(lFormat, (int) vMin), pX, pY - numberSize / 2);
                applet.textAlign(PConstants.RIGHT);
                applet.text(String.format(lFormat, (int) vMax), pX + pW, pY - numberSize / 2);
            } else {
                applet.pushMatrix();
                applet.textAlign(PConstants.RIGHT);
                applet.translate(pX - numberSize / 2, pY);
                applet.rotate(HALF_PI);
                applet.text(String.format(lFormat, (int) vMax), 0, 0);
                applet.popMatrix();
                applet.pushMatrix();
                applet.textAlign(PConstants.LEFT);
                applet.translate(pX - numberSize / 2, pY + pW);
                applet.rotate(HALF_PI);
                applet.text(String.format(lFormat, (int) vMin), 0, 0);
                applet.popMatrix();
            }
        }
    }

    private void drawVertical() {
        if (backgroundVisible) {
            applet.fill(sliderBack);
            applet.rect(pX, pY, pH, pW);
        }
        applet.fill(sliderFill);
        applet.rect(pX, pY + pW, pH, pScaled - pW);
    }

    private void drawHorizontal() {
        if (backgroundVisible) {
            applet.fill(sliderBack);
            applet.rect(pX, pY, pW, pH);
        }
        applet.fill(sliderFill);
        applet.rect(pX, pY, pScaled, pH);
    }

    public void draw() {
        applet.pushStyle();
        applet.noStroke();
        if (horizontal) {
            drawHorizontal();
        } else {
            drawVertical();
        }
        displayText();
        applet.popStyle();
        change();
    }

    public void mouseEvent(processing.event.MouseEvent evt) {
        if (evt.getAction() == processing.event.MouseEvent.WHEEL) {
            if (scrollWheelHandler != null) {
                    scrollWheelHandler.handleWheel((short) evt.getCount());
            }
        }        
    }

    /**
     *
     * @param value
     */
    public void setValue(float value) {
        if (value > vMax) {
            value = vMax;
        }
        if (value < vMin) {
            value = vMin;
        }
        pValue = value;
        if (horizontal) {
            pScaled = map(pValue, vMin, vMax, 0, pW);
        } else {
            pScaled = map(pValue, vMin, vMax, pW, 0);
        }
    }

    private void checkKeyboard() {
        if (mouseOver()) {
            if (applet.mousePressed && applet.mouseButton == PConstants.LEFT) {
                if (horizontal) {
                    pValue = constrainMap(applet.mouseX - pX, 0, pW, vMin, vMax);
                } else {
                    pValue = constrainMap(applet.mouseY - pY, pW, 0, vMin, vMax);
                }
            }
            if (applet.keyPressed && pressOnlyOnce) {
                if (applet.keyCode == PConstants.LEFT || applet.keyCode == PConstants.DOWN) {
                    pValue--;
                }
                if (applet.keyCode == PConstants.RIGHT || applet.keyCode == PConstants.UP) {
                    pValue++;
                }
                if (pValue > vMax) {
                    pValue = vMax;
                } else {
                    pValue = (pValue < vMin) ? vMin : pValue;
                }
                pressOnlyOnce = false;
            }
            deBounce(5);
            if (horizontal) {
                pScaled = map(pValue, vMin, vMax, 0, pW);
            } else {
                pScaled = map(pValue, vMin, vMax, pW, 0);
            }
        }
    }

    private void change() {
        
        checkKeyboard();
    }

    /**
     *
     * @return
     */
    public float readValue() {
        return pValue;
    }

    /**
     *
     * @param delta
     */
    public void changeWithWheel(int delta) {
        if (!mouseOver()) {
            return;
        }
        if (!horizontal) {
            delta = -delta;
        }
        if (applet.keyPressed && applet.keyCode == PConstants.SHIFT) {
            delta = delta * (int) (vMax / 10);
        }
        if (applet.keyPressed && applet.keyCode == PConstants.CONTROL) {
            delta = delta * (int) (vMax / 4);
        }
        setValue(pValue + delta);
    }

    private void deBounce(int n) {
        if (pressOnlyOnce) {
        } else if (deb++ > n) {
            deb = 0;
            pressOnlyOnce = true;
        }
    }

    private float map(float val, float begIn, float endIn, float beginOut, float endOut) {
        return (beginOut + (endOut - beginOut) * ((val - begIn) / (endIn - begIn)));
    }

    private int constrainMap(double val, double begIn, double endIn, double beginOut, double endOut) {
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

    public void dispose() {
        setActive(false);
    }

    /**
     *
     * @return
     */
    @Override
    public String toString() {
        String geomF = "SliderBar.new(%d, %d, %d, %.2f, %.2f, \"%s\")";
        return String.format(geomF, pX, pY, pW, vMin, vMax, ID);
    }
}
