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
import processing.core.PConstants;

public class CustomHorizontalSlider extends SliderBar {

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
    public CustomHorizontalSlider(final PApplet outer, int x, int y, int length, float beginRange, float endRange, String label) {
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

    @Override
    boolean mouseOver() {
        return (applet.mouseX >= pX && applet.mouseX <= pX + pW && applet.mouseY >= pY && applet.mouseY <= pY + pH);
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

    @Override
    void displayText() {
        String lFormat = "%d";
        if (displayLabel) {
            applet.fill(labelColor);
            applet.textSize(labelSize);
            applet.textAlign(PConstants.CENTER);
            applet.text(Integer.toString((int) pValue), pX + pW / 2, pY + pH / 2 + labelSize / 2 - 2);
        }
        if (displayValue) {
            applet.textSize(numberSize);
            applet.fill(numbersColor);
            applet.textAlign(PConstants.LEFT);
            applet.text(String.format(lFormat, (int) vMin), pX, pY - numberSize / 2);
            applet.textAlign(PConstants.RIGHT);
            applet.text(String.format(lFormat, (int) vMax), pX + pW, pY - numberSize / 2);
        }
    }
    
    @Override
    void drawGui() {
        if (backgroundVisible) {
            applet.fill(sliderBack);
            applet.rect(pX, pY, pW, pH);
        }
        applet.fill(sliderFill);
        applet.rect(pX, pY, pScaled, pH);
    }    

    /**
     *
     * @param value
     */
    @Override
    public void setValue(float value) {
        if (value > vMax) {
            value = vMax;
        }
        if (value < vMin) {
            value = vMin;
        }
        pValue = value;
        pScaled = map(pValue, vMin, vMax, 0, pW);
    }

    @Override
    void checkKeyboard() {
        if (mouseOver()) {
            if (applet.mousePressed && applet.mouseButton == PConstants.LEFT) {
                pValue = constrainMap(applet.mouseX - pX, 0, pW, vMin, vMax);
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
            pScaled = map(pValue, vMin, vMax, 0, pW);
        }
    }

    /**
     *
     * @param delta
     */
    @Override
    public void changeWithWheel(int delta) {
        if (!mouseOver()) {
            return;
        }
        if (applet.keyPressed && applet.keyCode == PConstants.SHIFT) {
            delta = delta * (int) (vMax / 10);
        }
        if (applet.keyPressed && applet.keyCode == PConstants.CONTROL) {
            delta = delta * (int) (vMax / 4);
        }
        setValue(pValue + delta);
    }
    
    /**
     *
     * @return
     */
    @Override
    public String toString() {
        String geomF = "HorizontalSliderBar.new(%d, %d, %d, %.2f, %.2f, \"%s\")";
        return String.format(geomF, pX, pY, pW, vMin, vMax, ID);
    }
}
