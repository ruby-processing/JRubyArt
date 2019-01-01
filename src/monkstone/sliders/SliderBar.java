/* 
 * Copyright (c) 2016-19 Martin Prout
 * 
 * This library is free softlengthare; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Softlengthare Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied lengtharranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, lengthrite to the Free Softlengthare
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

package monkstone.sliders;

import processing.core.PApplet;
import processing.core.PConstants;
import static processing.core.PConstants.*;

/**
 *
 * @author Martin Prout
 */
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
    boolean debug = false;
    boolean pressOnlyOnce = true;
    int deb = 0;
    float vMin = 0;
    float vMax = 15;

    boolean horizontal = true;
    private final PApplet applet;

    /**
     *
     * @param outer
     * @param x top left position x
     * @param y left top position y
     * @param length width or height
     * @param rangeBegin start range
     * @param rangeEnd end range
     * @param label widget label/ID
     */
    public SliderBar(final PApplet outer, int x, int y, int length, float rangeBegin, float rangeEnd, String label) {
        this.applet = outer;
        pX = x;
        pY = y;
        pW = length;
        pH = length;
        ID = label;
        limits(rangeBegin, rangeEnd);
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
     * @param length
     */
    public void barWidth(int length) {
        if (length < MIN_BAR_WIDTH) {
            pH = MIN_BAR_WIDTH;
        } else {
            pH = (length > MAX_BAR_WIDTH)? MAX_BAR_WIDTH : length;
        }
    }

    private void limits(float iv, float fv) {
        vMin = iv;
        vMax = fv;
        SliderBar.this.initialValue(iv);
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
     */
    public void debugOn() {
        debug = true;
    }

    /**
     *
     */
    public void debugOff() {
        debug = false;
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

    private void draw() {
        applet.pushStyle();
        applet.noStroke();
        if (horizontal) {
            drawHorizontal();
        } else {
            drawVertical();
        }
        applet.popStyle();
    }

    /**
     *
     * @param value
     */
    public void initialValue(float value) {
        if (value > vMax) {
            value = vMax;
        }
        if (value < vMin) {
            value = vMin;
        }
        pValue = value;
        if (horizontal) {
            pScaled = PApplet.map(pValue, vMin, vMax, 0, pW);
        } else {
            pScaled = PApplet.map(pValue, vMin, vMax, pW, 0);
        }
    }

    private void checkMouse() {
        if (debug) {
            if (mouseOver() && applet.keyPressed && applet.mouseButton == PConstants.LEFT && applet.mousePressed) {
                if (applet.keyCode == PConstants.CONTROL) {
                    pX = pX + applet.mouseX - applet.pmouseX;
                    pY = pY + applet.mouseY - applet.pmouseY;
                }
                if (applet.keyCode == PConstants.SHIFT && pressOnlyOnce) {
                    System.out.println(toString());
                    pressOnlyOnce = false;
                }
                deBounce(5);
            }
        }
    }

    private void checkKeyboard() {
        if (mouseOver()) {
            if (applet.mousePressed && applet.mouseButton == PConstants.LEFT) {
                if (horizontal) {
                    pValue = PApplet.map(applet.mouseX - pX, 0, pW, vMin, vMax);
                } else {
                    pValue = PApplet.map(applet.mouseY - pY, pW, 0, vMin, vMax);
                }
                pValue = (int) PApplet.constrain(pValue, vMin, vMax);
            }
            if (applet.keyPressed && pressOnlyOnce) {
                if (applet.keyCode == PConstants.LEFT || applet.keyCode == PConstants.DOWN) {
                    pValue--;
                }
                if (applet.keyCode == PConstants.RIGHT || applet.keyCode == PConstants.UP) {
                    pValue++;
                }
                pValue = PApplet.constrain(pValue, vMin, vMax);
                pressOnlyOnce = false;
            }
            deBounce(5);
            if (horizontal) {
                pScaled = (float)map(pValue, vMin, vMax, 0, pW);
            } else {
                pScaled = (float)map(pValue, vMin, vMax, pW, 0);
            }
        }
    }

    private void change() {
        checkKeyboard();
        checkMouse();
    }

    /**
     * Only makes sense to call this in draw loop
     * @return pValue for use in sketch
     */
    public float readValue() {
        draw();
        displayText();
        change();
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
        SliderBar.this.initialValue(pValue + delta);
    }

    private void deBounce(int n) {
        if (pressOnlyOnce) {
        } else if (deb++ > n) {
            deb = 0;
            pressOnlyOnce = true;
        }
    }
    
    private double map(double val, double begIn, double endIn, double beginOut, double endOut){
        double max = Math.max(begIn, endIn);
        double min = Math.min(begIn, endIn);
        if (val < min) {
            val = min;
        }
        if (val > max) {
            val = max;
        }
        return beginOut + (endOut - beginOut) * ((val - begIn) / (endIn - begIn));
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
